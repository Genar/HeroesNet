//
//  AppDelegate.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import UIKit
import EamCoreUtils
import EamCoreServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  var coordinator: BaseCoordinatorProtocol?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let navController = UINavigationController()

    let baseConfig: BaseConfigProtocol = BaseConfigPro()
    let endPoints: EndPointsProtocol = EndPoints()
    let requestService: NetworkRequestServiceProtocol = NetworkRequestService()
    let reachabilityService: ReachabilityServiceProtocol = ReachabilityService(urlStr: "https://www.google.com")

    let repository: RepositoryProtocol = Repository(baseConfig: baseConfig,
                                                    endPoints: endPoints,
                                                    requestService: requestService,
                                                    reachabilityService: reachabilityService)
        
    coordinator = HeroesListCoordinator(navigationController: navController,
                                        repository: repository)

    coordinator?.start()

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()

    return true
  }
}
