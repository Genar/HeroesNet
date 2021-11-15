//
//  BaseConfigPro.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import EamDomain

public class BaseConfigPro: BaseConfigProtocol {
    
  public var baseUrl: String = "http://gateway.marvel.com/"
  
  public init() { }
}
