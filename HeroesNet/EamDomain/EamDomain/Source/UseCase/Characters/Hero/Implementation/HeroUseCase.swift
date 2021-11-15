//
//  HeroUseCase.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation

public final class HeroUseCase: HeroUseCaseProtocol {
  
  private let provider: HeroesProviderProtocol
  
  public init(provider: HeroesProviderProtocol) {
    
    self.provider = provider
  }
}

extension HeroUseCase {
  
  public func execute(code: Int, completion: ((Result<HeroDomain, Error>) -> Void)? ) {
    
    provider.getHero(code: code) { result in
      completion?(result)
    }
  }
}
