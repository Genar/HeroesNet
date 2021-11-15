//
//  AuthConfigProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 15/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation

public protocol AuthConfigProtocol {
    
  var apiKey: String { get set }
  var timestamp: Int { get set }
  var hash: String { get set }
}
