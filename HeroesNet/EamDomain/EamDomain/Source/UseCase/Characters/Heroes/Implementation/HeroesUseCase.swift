//
//  HeroesUseCase.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

public final class HeroesUseCase: HeroesUseCaseProtocol {
  
  private let provider: HeroesProviderProtocol
  
  public init(provider: HeroesProviderProtocol) {
    
    self.provider = provider
  }
}

extension HeroesUseCase {
  
  public func execute(limit: Int, offset: Int, completion: ((Result<[HeroDomain], Error>) -> Void)? ) {
    
    provider.getHeroes(limit: limit, offset: offset) { result in
      completion?(result)
    }
  }
}
