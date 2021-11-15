//
//  AppDelegate+DependenciesInjection.swift
//  HeroesNet
//
//  Created by Genar Codina on 18/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import UIKit
import Resolver
import EamDomain
import EamData
import EamCoreServices

extension Resolver: ResolverRegistering {
  
  public static func registerAllServices() {

    registerProviders()
    registerUseCases()
  }
}

extension Resolver {
  
  public static func registerProviders() {
    
    register { AuthConfig() }
        .implements(AuthConfigProtocol.self)
    
    register { BaseConfigPro() }
        .implements(BaseConfigProtocol.self)
    
    register { EndPoints() }
        .implements(EndPointsProtocol.self)
    
    register { NetworkRequestService() }
        .implements(NetworkRequestServiceProtocol.self)
    
    register { ReachabilityService(urlStr: "https://www.google.com") }
        .implements(ReachabilityServiceProtocol.self)
    
    register { HeroesProvider(
      authConfig: Resolver.resolve(AuthConfigProtocol.self),
      baseConfig: Resolver.resolve(BaseConfigProtocol.self),
      endPoints: Resolver.resolve(EndPointsProtocol.self),
      requestService: Resolver.resolve(NetworkRequestServiceProtocol.self)) }
        .implements(HeroesProviderProtocol.self)
    
    register { ReachabilityProvider(reachabilityService: Resolver.resolve(ReachabilityServiceProtocol.self)) }
        .implements(ReachabilityProviderProtocol.self)
  }
  
  public static func registerUseCases() {
    
    register { HeroesUseCase(provider: Resolver.resolve(HeroesProviderProtocol.self)) }
    .implements(HeroesUseCaseProtocol.self)
    
    register { HeroUseCase(provider: Resolver.resolve(HeroesProviderProtocol.self)) }
    .implements(HeroUseCaseProtocol.self)
    
    register { IsConnectionOnUseCase(provider: Resolver.resolve(ReachabilityProviderProtocol.self)) }
        .implements(IsConnectionOnUseCaseProtocol.self)

    register { StartNetworkMonitoringUseCase(provider: Resolver.resolve(ReachabilityProviderProtocol.self)) }
        .implements(StartNetworkMonitoringUseCaseProtocol.self)
  }
}

enum HeroesInjector {

  static func buildHeroesListCoordinator(navigationController: UINavigationController) -> HeroesListCoordinatorProtocol {
        
    return HeroesListCoordinator(navigationController: navigationController,
                                 heroesUseCase: Resolver.resolve(),
                                 isConnectionOnUseCase: Resolver.resolve(),
                                 startNetworkMonitoringUseCase: Resolver.resolve())
  }
}
