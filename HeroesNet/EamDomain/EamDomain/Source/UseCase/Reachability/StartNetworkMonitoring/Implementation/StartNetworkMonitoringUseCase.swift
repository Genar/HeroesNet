//
//  StartNetworkMonitoringUseCase.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import Network

public final class StartNetworkMonitoringUseCase: StartNetworkMonitoringUseCaseProtocol {
  
  private let provider: ReachabilityProviderProtocol
  
  public init(provider: ReachabilityProviderProtocol) {
    
    self.provider = provider
  }
}

extension StartNetworkMonitoringUseCase {
  
  public func execute(pathUpdateHandler: ((NWPath) -> Void)?) {
    
    self.provider.startNetworkMonitoring(pathUpdateHandler: pathUpdateHandler)
  }
}
