//
//  AuthConfigMock.swift
//  EamDataTests
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import EamDomain

class AuthConfigMock: AuthConfigProtocol {
  
  var apiKey: String = "apiKey"
  
  var timestamp: Int = 12345
  
  var hash: String = "abcdf"
  
  init() { }
}
