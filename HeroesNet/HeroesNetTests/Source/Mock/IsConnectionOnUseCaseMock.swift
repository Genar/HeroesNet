//
//  IsConnectionOnUseCaseMock.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import Network
import EamDomain
@testable import HeroesNet

class IsConnectionOnUseCaseMock: IsConnectionOnUseCaseProtocol {
  
  func execute() -> Bool {
    
    return true
  }
}
