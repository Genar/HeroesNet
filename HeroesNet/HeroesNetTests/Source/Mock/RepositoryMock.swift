//
//  RepositoryMock.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 10/11/21.
//

import Foundation
import Network
@testable import HeroesNet

class RepositoryMock: RepositoryProtocol {

  func getHeroes(limit: Int, offset: Int, completion: ((Result<[HeroEntity], Error>) -> Void)? ) {
    
    let heroEntityOne = HeroEntity(id: 12345,
                                   name: "Ant-Man",
                                   resultDescription: "Ant-Man description",
                                   modified: nil,
                                   thumbnail: nil,
                                   resourceURI: nil,
                                   comics: nil,
                                   series: nil,
                                   stories: nil,
                                   events: nil,
                                   urls: nil,
                                   image: nil)
    
    let heroEntityTwo = HeroEntity(id: 34567,
                                   name: "Daredevil",
                                   resultDescription: "Daredevil description",
                                   modified: nil,
                                   thumbnail: nil,
                                   resourceURI: nil,
                                   comics: nil,
                                   series: nil,
                                   stories: nil,
                                   events: nil,
                                   urls: nil,
                                   image: nil)
    
    let heroArray = [heroEntityOne, heroEntityTwo]
    
    completion?(.success(heroArray))
  }
  
  func getHero(code: Int, completion: ((Result<HeroEntity, Error>) -> Void)? ) {
    
    let heroEntityOne = HeroEntity(id: 12345,
                                   name: "Ant-Man",
                                   resultDescription: "Ant-Man description",
                                   modified: nil,
                                   thumbnail: nil,
                                   resourceURI: nil,
                                   comics: nil,
                                   series: nil,
                                   stories: nil,
                                   events: nil,
                                   urls: nil,
                                   image: nil)
    
    completion?(.success(heroEntityOne))
  }
  
  func getHero(withHeroId id: String, completion: ((HeroEntity) -> ())?) {
  }
  
  func isNetworkOn() -> Bool {
    
    return true
  }
  
  func startNetworkMonitoring(pathUpdateHandler: ((NWPath) -> Void)?) {
  }
}
