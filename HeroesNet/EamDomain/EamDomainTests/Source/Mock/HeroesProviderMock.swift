//
//  HeroesProviderMock.swift
//  EamDomainTests
//
//  Created by Genar Codina on 18/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import EamDomain

class HeroesProviderMock: HeroesProviderProtocol {
  
  func getHeroes(limit: Int, offset: Int, completion: ((Result<[HeroDomain], Error>) -> Void)?) {
    
    let heroes = getTwoHeroes()
    
    completion?(.success(heroes))
  }
  
  func getHero(code: Int, completion: ((Result<HeroDomain, Error>) -> Void)?) {
    
    let hero = getOneHero()
    
    completion?(.success(hero))
  }
  
  private func getOneHero() -> HeroDomain {
    
    return HeroDomain(id: 1,
                      name: "Daredevil",
                      description: "Daredevil description",
                      numSeries: "10",
                      numComics: "110",
                      numEvents: "20",
                      numStories: "30",
                      thumbnailUrl: nil,
                      image: nil,
                      url: nil)
  }
  
  private func getTwoHeroes() -> [HeroDomain] {
    
    let heroOne = HeroDomain(id: 1,
                             name: "Daredevil",
                             description: "Daredevil description",
                             numSeries: "10",
                             numComics: "110",
                             numEvents: "20",
                             numStories: "30",
                             thumbnailUrl: nil,
                             image: nil,
                             url: nil)
    
    let heroTwo = HeroDomain(id: 1,
                             name: "Ant-Man",
                             description: "Ant-Man description",
                             numSeries: "9",
                             numComics: "89",
                             numEvents: "15",
                             numStories: "29",
                             thumbnailUrl: nil,
                             image: nil,
                             url: nil)
    
    return [heroOne, heroTwo]
  }
}
