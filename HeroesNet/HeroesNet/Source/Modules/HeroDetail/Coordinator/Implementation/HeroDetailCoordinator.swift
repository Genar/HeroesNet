//
//  HeroDetailCoordinator.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import UIKit
import EamCoreUtils
import EamDomain

class HeroDetailCoordinator: BaseCoordinatorProtocol, HeroDetailCoordinatorProtocol, HeroDetailViewModelCoordinatorDelegate {
 
  /// Parent coordinator
  weak var parentCoordinator: HeroesListCoordinator?

  /// Coordinator can have child coordinators
  var childCoordinators: [BaseCoordinatorProtocol] = [BaseCoordinatorProtocol]()

  /// Navigation controller to push view controllers
  var navigationController: UINavigationController
  
  /// IsConnectionOnUseCase for the view model
  var isConneciontOnUseCase: IsConnectionOnUseCaseProtocol

  /// Info to pass between coordinators
  var heroInfo: HeroDomain?

  lazy var viewModel: HeroDetailViewModelProtocol! = {
    let viewModel = HeroDetailViewModel(isConnectionOnUseCase: self.isConneciontOnUseCase)
    return viewModel
  }()
  
  private let storyboardName = "Main"

  /// Inits the coordinator
  /// - Parameter navigationController: navigation controller
  init(navigationController: UINavigationController,
       isConneciontOnUseCase: IsConnectionOnUseCaseProtocol) {
    
    self.navigationController = navigationController
    self.isConneciontOnUseCase = isConneciontOnUseCase
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
