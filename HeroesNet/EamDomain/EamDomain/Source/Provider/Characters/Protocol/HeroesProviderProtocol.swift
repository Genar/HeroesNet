//
//  ProviderListProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 15/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

public protocol HeroesProviderProtocol {
  
  func getHeroes(limit: Int, offset: Int, completion: ((Result<[HeroDomain], Error>) -> Void)? )
  
  func getHero(code: Int, completion: ((Result<HeroDomain, Error>) -> Void)?)
}
