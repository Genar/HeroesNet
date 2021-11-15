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
  
  var viewModel: HeroDetailViewModelProtocol!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {

    super.viewWillAppear(animated)
    viewModel.viewWillAppear()
  }
  
  deinit {
    if webView != nil {
      webView.stopLoading()
    }
  }
  
  private func setupUI() {
      
    self.viewModel.showHero = { [weak self] in
      guard let self = self else { return }
      self.fillHeroInfo()
      self.setupWebView()
    }
    
    self.viewModel.enableAnimation = { [weak self] enable in
      guard let self = self else { return }
      _ = enable ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
    }
    
    webView.navigationDelegate = self
  }
  
  private func fillHeroInfo() {
    
    let hero = viewModel.getHeroInfo()
    self.heroNameLabel.text = hero.name
    self.descriptionLabel.text = hero.description
    self.numberOfSeriesLabel.text = hero.numSeries
    self.numberOfComicsLabel.text = hero.numComics
    self.numberOfEventsLabel.text = hero.numEvents
    self.numberOfStoriesLabel.text = hero.numStories

    guard let imageData = hero.image,
          let image = UIImage(data: imageData) else { return }
      self.heroImageView.image = image
  }
  
  private func setupWebView() {

    let config = WKWebViewConfiguration()

    if #available(iOS 13.0, *) {
        let pref = WKWebpagePreferences.init()
        pref.preferredContentMode = .mobile
        config.defaultWebpagePreferences = pref
    }
    
    config.limitsNavigationsToAppBoundDomains = true

    guard let heroUri = self.viewModel.getHeroUrlInfo() else { return }
    self.webView.load(URLRequest(url: heroUri))
  }
  
}

extension HeroDetailViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
    self.viewModel.stopAnimation()
  }
  
}
