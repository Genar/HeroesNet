//
//  HeroesUseCase.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

public final class HeroesUseCase {
  
  private let provider: HeroesProviderProtocol
  
  public init(provider: HeroesProviderProtocol) {
    
    self.provider = provider
  }
}

extension HeroesUseCase: HeroesUseCaseProtocol {
  
  public func execute(limit: Int, offset: Int, completion: ((Result<[HeroDomain], Error>) -> Void)? ) {
    
    provider.getHeroes(limit: limit, offset: offset) { result in
      completion?(result)
    }
  }
}
