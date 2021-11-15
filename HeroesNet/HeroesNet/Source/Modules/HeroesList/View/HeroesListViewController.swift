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
  
  var viewModel: HeroesListViewModelProtocol!
  
  override func viewDidLoad() {
      
  super.viewDidLoad()
    
    setupBindings()
    setupTableViewDelegates()
    viewModel.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground),
                                           name: UIApplication.willEnterForegroundNotification,
                                           object: nil)
  }
  
  @objc private func willEnterForeground() {
    
    viewModel.willEnterForeground()
  }
  
  private func setupTableViewDelegates() {
      
    self.heroesTableView.dataSource = self
    self.heroesTableView.delegate = self
  }
  
  private func setupBindings() {
      
    self.viewModel.showHeroes = { [weak self] arrayOfIndexes in
      guard let self = self else { return }
      self.heroesTableView.insertRows(at: arrayOfIndexes, with: .fade)
    }
    
    self.viewModel.enableUserInteraction = { [weak self] canUserInteract in
      guard let self = self else { return }
      self.heroesTableView.isUserInteractionEnabled = canUserInteract
      self.heroesTableView.isScrollEnabled = canUserInteract
      _ = canUserInteract ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
    }
    
    let warningInfo = self.viewModel.getWarningInfo()
    self.warningLabel.bind(to: warningInfo)
  }
  
}

extension HeroesListViewController: UITableViewDataSource {
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
    return viewModel.numberOfRowsInSection(section: section)
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
    
    viewModel.loadMoreItems()
  }
  
  private func renderCell(cell: HerotItemTableViewCell, indexPath: IndexPath) {
    
    let heroItem = viewModel.getCellInfo(indexPath: indexPath)
    cell.fill(with: heroItem)

    if viewModel.isConnectionOn() {
      renderFromNetwork(indexPath: indexPath, cell: cell)
    }
  }
  
  private func renderFromNetwork(indexPath: IndexPath, cell: HerotItemTableViewCell) {
    
    cell.heroImageView.image = UIImage(named: HeroItemStrings.heroEmptyImageKey)
    viewModel.renderImage(index: indexPath.row) { data in
      guard let image = UIImage(data: data) else { return }
      if let imagePng = image.pngData() {
        cell.heroImageView.image = UIImage(data: imagePng)
    }
    }
  }
}

extension HeroesListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      viewModel.showDetail(indexPath: indexPath)
  }
}
