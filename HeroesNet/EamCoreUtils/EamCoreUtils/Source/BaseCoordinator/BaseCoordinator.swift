//
//  BaseCoordinator.swift
//  EamCoreUtils
//
//  Created by Genar Codina on 11/11/21.
//

import UIKit

/// BaseCoordinatorProtocol is an "AnyObject" because coordinators
/// have to be classes so that they can be shared in different places.
public protocol BaseCoordinatorProtocol: AnyObject {
    
    /// Child coordinators is a way to make your code easier to follow.
    var childCoordinators: [BaseCoordinatorProtocol] { get set }
    
    var navigationController: UINavigationController { get set }

    func start()
}
