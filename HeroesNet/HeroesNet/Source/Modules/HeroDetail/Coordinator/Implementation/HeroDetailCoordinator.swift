//
//  HeroDetailCoordinator.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import UIKit
import EamCoreUtils

class HeroDetailCoordinator: BaseCoordinatorProtocol, HeroDetailCoordinatorProtocol, HeroDetailViewModelCoordinatorDelegate {
 
  /// Parent coordinator
  weak var parentCoordinator: HeroesListCoordinator?

  /// Coordinator can have child coordinators
  var childCoordinators: [BaseCoordinatorProtocol] = [BaseCoordinatorProtocol]()

  /// Navigation controller to push view controllers
  var navigationController: UINavigationController

  /// Repository for the view model
  var repository: RepositoryProtocol

  /// Info to pass between coordinators
  var heroInfo: HeroEntity?

  lazy var viewModel: HeroDetailViewModelProtocol! = {
      let viewModel = HeroDetailViewModel(repository: self.repository)      
      return viewModel
  }()
  
  private let storyboardName = "Main"

  /// Inits the coordinator
  /// - Parameter navigationController: navigation controller
  init(navigationController: UINavigationController,
       repository: RepositoryProtocol) {
      
      self.navigationController = navigationController
      self.repository = repository
  }
  
  /// Pushes the view controller
  func start() {
      
    guard let viewCtrl = HeroDetailViewController.instantiate(storyBoardName: storyboardName) else { return }
      
    // Setup the view model
    viewModel.coordinatorDelegate = self
    viewCtrl.viewModel = viewModel
    viewModel.heroInfo = heroInfo
      
    navigationController.pushViewController(viewCtrl, animated: true)
  }
}
