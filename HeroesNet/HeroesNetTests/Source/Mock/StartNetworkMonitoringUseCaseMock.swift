//
//  StartNetworkMonitoringUseCaseMock.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import Network
import EamDomain
@testable import HeroesNet

class StartNetworkMonitoringUseCaseMock: StartNetworkMonitoringUseCaseProtocol {
  
  func execute(pathUpdateHandler: ((NWPath) -> Void)?) {
  }
}
