//
//  HeroesUseCaseMock.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import Network
import EamDomain
@testable import HeroesNet

class HeroesUseCaseMock: HeroesUseCaseProtocol {
  
  func execute(limit: Int, offset: Int, completion: ((Result<[HeroDomain], Error>) -> Void)?) {
    
    let heroDomainOne = HeroDomain(id: 12345,
                                   name: "Ant-Man",
                                   description: "Ant-Man description",
                                   numSeries: "3",
                                   numComics: "4",
                                   numEvents: "5",
                                   numStories: "6",
                                   thumbnailUrl: nil,
                                   image: nil,
                                   url: nil)
    
    let heroDomainTwo = HeroDomain(id: 34567,
                                   name: "Daredevil",
                                   description: "Daredevil description",
                                   numSeries: "5",
                                   numComics: "6",
                                   numEvents: "7",
                                   numStories: "8",
                                   thumbnailUrl: nil,
                                   image: nil,
                                   url: nil)
    
    let heroArray = [heroDomainOne, heroDomainTwo]
    
    completion?(.success(heroArray))
  }
}
