//
//  StartNetworkMonitoringUseCaseProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import Network

public protocol StartNetworkMonitoringUseCaseProtocol {
  
  func execute(pathUpdateHandler: ((NWPath) -> Void)?)
}
