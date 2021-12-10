//
//  IsConnectionOnUseCase.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation

public final class IsConnectionOnUseCase {
  
  private let provider: ReachabilityProviderProtocol
  
  public init(provider: ReachabilityProviderProtocol) {
    
    self.provider = provider
  }
}

extension IsConnectionOnUseCase: IsConnectionOnUseCaseProtocol {
  
  public func execute() -> Bool {
    
    return provider.isNetworkOn()
  }
}
