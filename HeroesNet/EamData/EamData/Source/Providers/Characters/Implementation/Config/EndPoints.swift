//
//  EndPoints.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import EamDomain

public class EndPoints: EndPointsProtocol {
    
  public var heroes: String = "v1/public/characters?limit=%@&offset=%@&ts=%@&apikey=%@&hash=%@"
  
  public var heroInfo: String = "v1/public/characters/%@?ts=%@&apikey=%@&hash=%@"
  
  public init() {}
}
