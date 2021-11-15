//
//  HeroesListViewController.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import UIKit
import EamCoreUtils

enum HeroesListViewStrings {
  
  static let HerotItemTableViewCellKey = "HerotItemTableViewCell"
}

final class HeroesListViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var heroesTableView: UITableView!
  
  @IBOutlet weak var warningLabel: BoundLabel!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  private let distanceFromBottom = 10.0
  
  var viewModel: HeroesListViewModelProtocol?
  
  override func viewDidLoad() {
      
  super.viewDidLoad()
    
    setupBindings()
    setupTableViewDelegates()
    viewModel?.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground),
                                           name: UIApplication.willEnterForegroundNotification,
                                           object: nil)
  }
  
  @objc private func willEnterForeground() {
    
    viewModel?.willEnterForeground()
  }
  
  private func setupTableViewDelegates() {
      
    self.heroesTableView.dataSource = self
    self.heroesTableView.delegate = self
  }
  
  private func setupBindings() {
      
    self.viewModel?.showHeroes = { [weak self] arrayOfIndexes in
      guard let self = self else { return }
      self.heroesTableView.insertRows(at: arrayOfIndexes, with: .fade)
    }
    
    self.viewModel?.enableUserInteraction = { [weak self] canUserInteract in
      guard let self = self else { return }
      self.heroesTableView.isUserInteractionEnabled = canUserInteract
      self.heroesTableView.isScrollEnabled = canUserInteract
      _ = canUserInteract ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
    }
    
    guard let warningInfo = self.viewModel?.warningsInfo.info else { return }
    self.warningLabel.bind(to: warningInfo)
  }
  
}

extension HeroesListViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
    return viewModel?.numberOfRowsInSection(section: section) ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
    if let cell = tableView.dequeueReusableCell(withIdentifier: HeroesListViewStrings.HerotItemTableViewCellKey,
                                                for: indexPath) as? HerotItemTableViewCell {
      renderCell(cell: cell, indexPath: indexPath)
      return cell
    } else {
      return UITableViewCell()
    }
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

    if maximumOffset - currentOffset <= distanceFromBottom {
      self.loadMoreItems()
    }
  }
  
  private func loadMoreItems() {
    
    guard let viewModel = self.viewModel else { return }
    viewModel.loadMoreItems()
  }
  
  private func renderCell(cell: HerotItemTableViewCell, indexPath: IndexPath) {
    
    if let heroes = viewModel?.heroes {
      let hero = heroes[indexPath.row]
      guard let heroName = hero.name,
            let heroDescription = (hero.resultDescription?.isEmpty ?? true) ?
              HeroItemStrings.noDescriptionAvailable.localized : hero.resultDescription else { return }
      let heroNumSeries = String(format: HeroItemStrings.numberOfSeries.localized,
                                 String(hero.series?.available ?? 0))
      let heroNumComics = String(format: HeroItemStrings.numberOfComics.localized,
                                 String(hero.comics?.available ?? 0))
      let heroItem = HeroItemCellModel(name: heroName,
                                       description: heroDescription,
                                       numSeries: heroNumSeries,
                                       numComics: heroNumComics)
      cell.fill(with: heroItem)
      
      if let connectionOn = viewModel?.isConnectionOn(), connectionOn {
        renderFromNetwork(indexPath: indexPath, cell: cell)
      }
    }
  }
  
  private func renderFromNetwork(indexPath: IndexPath, cell: HerotItemTableViewCell) {
    
    if let heroes = viewModel?.heroes {
      cell.heroImageView.image = UIImage(named: HeroItemStrings.heroEmptyImageKey)
      var heroItem = heroes[indexPath.row]
      if let imageUrl = heroItem.thumbnail,
         let imagePath = imageUrl.path,
         let imageExtension = imageUrl.thumbnailExtension?.rawValue,
         let urlPath = URL(string: imagePath + "." + imageExtension) {
        NetworkUtils.downloadImage(from: urlPath) { (data, response, error) in
          guard let data = data, let _ = response, error == nil else { return }
          guard let image = UIImage(data: data) else { return }
          if let imagePng = image.pngData() {
            heroItem.image = imagePng
            self.viewModel?.heroes[indexPath.row].image = imagePng
            cell.heroImageView.image = UIImage(data: imagePng)
          }
        }
      }
    }
  }
  
}

extension HeroesListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    if let viewModel = self.viewModel, !viewModel.heroes.isEmpty {
       let hero = viewModel.heroes[indexPath.row]
        viewModel.showDetail(heroInfo: hero)
    }
  }
}
