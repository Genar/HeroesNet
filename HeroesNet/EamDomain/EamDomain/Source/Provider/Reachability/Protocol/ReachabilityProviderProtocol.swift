//
//  ReachabilityProviderProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import Network

public protocol ReachabilityProviderProtocol {
  
  func isNetworkOn() -> Bool
  
  func startNetworkMonitoring(pathUpdateHandler: ((NWPath) -> Void)?)
}
