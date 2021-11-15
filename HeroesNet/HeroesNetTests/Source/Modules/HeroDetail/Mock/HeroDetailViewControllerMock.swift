//
//  HeroDetailViewControllerMock.swift
//  HeroesNet
//
//  Created by Genar Codina on 12/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import UIKit
@testable import HeroesNet

class HeroDetailViewControllerMock: UIViewController {
  
  var viewModel: HeroDetailViewModelProtocol?
  
  var isAnimationEnabled: Bool?
  
  var hero: HeroEntity?

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
      self.hero = hero
    }
    
    self.viewModel?.enableAnimation = { [weak self] enable in
      guard let self = self else { return }
      self.isAnimationEnabled = enable
    }
  }
  
}
