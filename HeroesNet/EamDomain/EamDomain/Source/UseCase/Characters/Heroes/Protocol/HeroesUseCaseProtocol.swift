//
//  HeroesUseCaseProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation

public protocol HeroesUseCaseProtocol {
  
  func execute(limit: Int, offset: Int, completion: ((Result<[HeroDomain], Error>) -> Void)? )
}
