//
//  HeroesListCoordinator.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import UIKit
import EamCoreUtils

class HeroesListCoordinator: NSObject, BaseCoordinatorProtocol {
  
  /// Parent coordinator can have child coordinators
  var childCoordinators = [BaseCoordinatorProtocol]()
  
  /// Navigation controller to push view controllers
  var navigationController: UINavigationController
  
  /// Repository for the view model
  var repository: RepositoryProtocol
  
  lazy var viewModel: HeroesListViewModelProtocol! = {
      let viewModel = HeroesListViewModel(repository: self.repository)
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
    
  /// Push the view controller
  func start() {
      
    guard let viewCtrl = HeroesListViewController.instantiate(storyBoardName: storyboardName) else { return }
    
    // Setup the view model
    viewModel.coordinatorDelegate = self
    viewCtrl.viewModel = viewModel
      
    // Navigation controller will inform this coordinator when a view controller is shown,
    // by making this main coordinator its delegate.
    navigationController.delegate = self
    navigationController.pushViewController(viewCtrl, animated: false)
  }
    
  /// Clean coordinators childs
  func didFinishChild(_ child: BaseCoordinatorProtocol?) {

    for (index, coordinator) in childCoordinators.enumerated() {
      if coordinator === child {
          childCoordinators.remove(at: index)
          break
      }
    }
  }
}

extension HeroesListCoordinator: HeroesListViewModelCoordinatorDelegate {
 
  /// Navigates to the detail view
  public func showDetail(heroInfo: HeroEntity) {
    
    let childCoordinator = HeroDetailCoordinator(navigationController: navigationController,
                                                 repository: repository)
    childCoordinator.parentCoordinator = self
    childCoordinator.heroInfo = heroInfo
    childCoordinators.append(childCoordinator)
    childCoordinator.start()
  }
}

/// It is the main coordinator and to detect interactions with the navigation controller (i.e. back navigation)
/// it has to inherit from UINavigationControllerDelegate (and consequently from NSObject)
extension HeroesListCoordinator: UINavigationControllerDelegate {
    
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
      
    // Read the view controller we are moving from.
    guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
      return
    }

    // Check whether our view controller array already contains that view controller.
    // If it does it means we are pushing a different view controller on top rather than popping it,
    // so exit.
    if navigationController.viewControllers.contains(fromViewController) {
      return
    }

    // We are still here – it means we are popping the view controller,
    // so we can check whether it is a detail view controller
    if let detailViewController = fromViewController as? HeroDetailViewController {
        // We are popping a detail view controller; end its coordinator
      didFinishChild(detailViewController.viewModel?.coordinatorDelegate as? (BaseCoordinatorProtocol & HeroDetailCoordinatorProtocol) )
    }
  }
}

extension HeroesListCoordinator: HeroesListCoordinatorProtocol {
  
}
