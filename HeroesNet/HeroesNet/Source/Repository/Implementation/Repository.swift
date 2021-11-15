//
//  Repository.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import Network
import EamCoreServices

enum NetworkError: Error {
  
  case statusCodeNotOK
}

enum InfoError: Error {
  
  case noHeroInfo
}

class Repository: RepositoryProtocol {
  
  let apikey = "169b10184304f259c537ca6077ee9df1"
  let timestamp = "1636378441"
  let hash = "257a134811b14488512f60d1d93f6772"

  let baseConfig: BaseConfigProtocol
  let endPoints: EndPointsProtocol
  let requestService: NetworkRequestServiceProtocol
  let reachabilityService: ReachabilityServiceProtocol
  
  init(baseConfig: BaseConfigProtocol,
       endPoints: EndPointsProtocol,
       requestService: NetworkRequestServiceProtocol,
       reachabilityService: ReachabilityServiceProtocol) {
      
    self.baseConfig = baseConfig
    self.endPoints = endPoints
    self.requestService = requestService
    self.reachabilityService = reachabilityService
  }
  
  // MARK: - Web services calls
  
  func getHeroes(limit: Int, offset: Int, completion: ((Result<[HeroEntity], Error>) -> Void)? ) {
    
    var heroesUrl = baseConfig.baseUrl + endPoints.heroes
    heroesUrl = String(format: heroesUrl, String(limit), String(offset), timestamp, apikey, hash)
    let heroesUrlWithNoSpace = heroesUrl.replacingOccurrences(of: " ", with: "%20")
    guard let url = URL(string: heroesUrlWithNoSpace) else { return }
    _ = requestService.request(url) { (result: Result<HeroesEntity, Error>) in
      switch result {
      case .success(let heroesEntity):
        guard let statusCode = heroesEntity.code, (200..<300) ~= statusCode else {
          completion?(.failure(NetworkError.statusCodeNotOK))
          return
        }
        let heroesArray = heroesEntity.data?.results ?? []
        completion?(.success(heroesArray))
      case .failure(let error):
        completion?(.failure(error))
      }
    }
  }
  
  func getHero(code: Int, completion: ((Result<HeroEntity, Error>) -> Void)?) {
    
    var heroesUrl = baseConfig.baseUrl + endPoints.heroInfo
    heroesUrl = String(format: heroesUrl, String(code), timestamp, apikey, hash)
    let heroesUrlWithNoSpace = heroesUrl.replacingOccurrences(of: " ", with: "%20")
    guard let url = URL(string: heroesUrlWithNoSpace) else { return }
    _ = requestService.request(url) { (result: Result<HeroesEntity, Error>) in
      switch result {
      case .success(let heroEntity):
        guard let statusCode = heroEntity.code, (200..<300) ~= statusCode else {
          completion?(.failure(NetworkError.statusCodeNotOK))
          return
        }
        let heroInfoArray = heroEntity.data?.results ?? []
        _ = heroInfoArray.isEmpty ? completion?(.failure(InfoError.noHeroInfo)) : completion?(.success(heroInfoArray[0]))
      case .failure(let error):
        completion?(.failure(error))
      }
    }
  }
  
  // MARK: - Reacability service calls
  
  func isNetworkOn() -> Bool {
      
      self.reachabilityService.isNetworkReachable()
  }
  
  func startNetworkMonitoring(pathUpdateHandler: ((NWPath) -> Void)?) {
      
      self.reachabilityService.startNetworkMonitoring(pathUpdateHandler: pathUpdateHandler)
  }
}
