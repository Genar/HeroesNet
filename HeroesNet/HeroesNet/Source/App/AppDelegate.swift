//
//  AppDelegate.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  var coordinator: HeroesListCoordinatorProtocol?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let navController = UINavigationController()
    self.coordinator = HeroesInjector.buildHeroesListCoordinator(navigationController: navController)
    
    coordinator?.start()

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()

    return true
  }
}
