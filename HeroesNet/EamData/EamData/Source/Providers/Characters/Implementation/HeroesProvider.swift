//
//  HeroesProvider.swift
//  HeroesNet
//
//  Created by Genar Codina on 15/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation
import EamCoreServices
import EamDomain

enum NetworkError: Error {
  
  case statusCodeNotOK
}

enum InfoError: Error {
  
  case noHeroInfo
}

public final class HeroesProvider: HeroesProviderProtocol {

  let authConfig: AuthConfigProtocol
  let baseConfig: BaseConfigProtocol
  let endPoints: EndPointsProtocol
  let requestService: NetworkRequestServiceProtocol
  
  public init(authConfig: AuthConfigProtocol,
              baseConfig: BaseConfigProtocol,
              endPoints: EndPointsProtocol,
              requestService: NetworkRequestServiceProtocol) {
    
    self.authConfig = authConfig
    self.baseConfig = baseConfig
    self.endPoints = endPoints
    self.requestService = requestService
  }
  
  public func getHeroes(limit: Int, offset: Int, completion: ((Result<[HeroDomain], Error>) -> Void)? ) {
    
    var heroesUrl = baseConfig.baseUrl + endPoints.heroes
    heroesUrl = String(format: heroesUrl,
                       String(limit),
                       String(offset),
                       String(authConfig.timestamp),
                       authConfig.apiKey,
                       authConfig.hash)
    let heroesUrlWithNoSpace = heroesUrl.replacingOccurrences(of: " ", with: "%20")
    guard let url = URL(string: heroesUrlWithNoSpace) else { return }
    _ = requestService.request(url) { (result: Result<HeroesEntity, Error>) in
      switch result {
      case .success(let heroesEntity):
        guard let statusCode = heroesEntity.code, (200..<300) ~= statusCode else {
          completion?(.failure(NetworkError.statusCodeNotOK))
          return
        }
        let heroes = heroesEntity.data?.results ?? []
        let heroesArray = heroes.compactMap { heroEntity in
          try? heroEntity.convertToDomain()
        }
        completion?(.success(heroesArray))
      case .failure(let error):
        completion?(.failure(error))
      }
    }
  }
  
  public func getHero(code: Int, completion: ((Result<HeroDomain, Error>) -> Void)?) {

    var heroesUrl = baseConfig.baseUrl + endPoints.heroInfo
    heroesUrl = String(format: heroesUrl,
                       String(code),
                       String(authConfig.timestamp),
                       authConfig.apiKey,
                       authConfig.hash)
    let heroesUrlWithNoSpace = heroesUrl.replacingOccurrences(of: " ", with: "%20")
    guard let url = URL(string: heroesUrlWithNoSpace) else { return }
    _ = requestService.request(url) { (result: Result<HeroesEntity, Error>) in
      switch result {
      case .success(let heroEntity):
        guard let statusCode = heroEntity.code, (200..<300) ~= statusCode else {
          completion?(.failure(NetworkError.statusCodeNotOK))
          return
        }
        guard let heroInfoArray = heroEntity.data?.results, !heroInfoArray.isEmpty else { return }
        do {
          let hero = try heroInfoArray[0].convertToDomain()
          completion?(.success(hero))
        } catch {
          completion?(.failure(InfoError.noHeroInfo))
        }
      case .failure(let error):
        completion?(.failure(error))
      }
    }
  }
  
}
