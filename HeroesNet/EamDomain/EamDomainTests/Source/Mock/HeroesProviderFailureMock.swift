//
//  HeroesProviderFailureMock.swift
//  EamDomainTests
//
//  Created by Genar Codina on 18/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import EamDomain
@testable import EamData

class HeroesProviderFailureMock: HeroesProviderProtocol {
  
  func getHeroes(limit: Int, offset: Int, completion: ((Result<[HeroDomain], Error>) -> Void)?) {
    
    let error = NetworkError.statusCodeNotOK
    
    completion?(.failure(error))
  }
  
  func getHero(code: Int, completion: ((Result<HeroDomain, Error>) -> Void)?) {
    
    let error = NetworkError.statusCodeNotOK
    
    completion?(.failure(error))
  }
}
