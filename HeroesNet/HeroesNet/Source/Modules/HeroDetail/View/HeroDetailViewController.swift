//
//  HeroDetailViewController.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import UIKit
import WebKit
import EamCoreUtils

final class HeroDetailViewController: UIViewController, Storyboarded {
  
  @IBOutlet weak var contentView: UIView!
  
  @IBOutlet weak var heroNameLabel: UILabel!
  
  @IBOutlet weak var heroImageView: UIImageView!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var numberOfSeriesLabel: UILabel!
  
  @IBOutlet weak var numberOfComicsLabel: UILabel!
  
  @IBOutlet weak var numberOfEventsLabel: UILabel!
  
  @IBOutlet weak var numberOfStoriesLabel: UILabel!
  
  @IBOutlet weak var webView: WKWebView!
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var viewModel: HeroDetailViewModelProtocol?

  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setupBindings()
  }
  
  override func viewWillAppear(_ animated: Bool) {

    super.viewWillAppear(animated)
    viewModel?.viewWillAppear()
  }
  
  private func setupBindings() {
      
    self.viewModel?.showHero = { [weak self] hero in
      guard let self = self else { return }
      self.fillHeroInfo(hero: hero)
      self.setupWebView(hero: hero)
    }
    
    self.viewModel?.enableAnimation = { [weak self] enable in
      guard let self = self else { return }
      _ = enable ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
    }
    
    webView.navigationDelegate = self
  }
  
  private func fillHeroInfo(hero: HeroEntity) {
    
    self.heroNameLabel.text = hero.name
    
    let description = hero.resultDescription ?? ""
    self.descriptionLabel.text = description

    let numberOfSeries = hero.series?.available ?? 0
    self.numberOfSeriesLabel.text = String(format: HeroItemStrings.numberOfSeries.localized,
                                           String(numberOfSeries))

    let numberOfComics = hero.comics?.available ?? 0
    self.numberOfComicsLabel.text = String(format: HeroItemStrings.numberOfComics.localized,
                                           String(numberOfComics))

    let numberOfEvents = hero.events?.available ?? 0
    self.numberOfEventsLabel.text = String(format: HeroItemStrings.numberOfEvents.localized,
                                           String(numberOfEvents))

    let numberOfStories = hero.stories?.collectionURI?.indices.count ?? 0
    self.numberOfStoriesLabel.text = String(format: HeroItemStrings.numberOfStories.localized,
                                            String(numberOfStories))

    guard let imageData = hero.image,
          let image = UIImage(data: imageData) else { return }
      self.heroImageView.image = image
  }
  
  private func setupWebView(hero: HeroEntity) {

    let config = WKWebViewConfiguration()

    if #available(iOS 13.0, *) {
        let pref = WKWebpagePreferences.init()
        pref.preferredContentMode = .mobile
        config.defaultWebpagePreferences = pref
    }

    guard let heroUris = hero.urls, !heroUris.isEmpty else { return }

    if let urlStr = heroUris[0].url, let url = URL(string: urlStr) {
      self.webView.load(URLRequest(url: url))
    }
  }
  
}

extension HeroDetailViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
    self.viewModel?.stopAnimation()
  }
  
}
