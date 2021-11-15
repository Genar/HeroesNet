//
//  ReachabilityProvider.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import Network
import EamCoreServices
import EamDomain

public final class ReachabilityProvider: ReachabilityProviderProtocol {
  
  let reachabilityService: ReachabilityServiceProtocol
  
  public init(reachabilityService: ReachabilityServiceProtocol) {
    
    self.reachabilityService = reachabilityService
  }
}

extension ReachabilityProvider {
  
  public func isNetworkOn() -> Bool {
    
    return self.reachabilityService.isNetworkReachable()
  }
  
  public func startNetworkMonitoring(pathUpdateHandler: ((NWPath) -> Void)?) {
    
    self.reachabilityService.startNetworkMonitoring(pathUpdateHandler: pathUpdateHandler)
  }
}
