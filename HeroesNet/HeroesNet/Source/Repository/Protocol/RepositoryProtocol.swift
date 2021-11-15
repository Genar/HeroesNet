//
//  RepositoryProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import Network

protocol RepositoryProtocol {
  
  // MARK: - Web services
  
  func getHeroes(limit: Int, offset: Int, completion: ((Result<[HeroEntity], Error>) -> Void)? )
  
  func getHero(code: Int, completion: ((Result<HeroEntity, Error>) -> Void)?)

  // MARK: - Reachability service
  
  func isNetworkOn() -> Bool
  
  func startNetworkMonitoring(pathUpdateHandler: ((NWPath) -> Void)?)
    
}
