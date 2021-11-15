//
//  HeroDetailProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import EamDomain

protocol HeroDetailCoordinatorProtocol: AnyObject {
    
    var heroInfo: HeroDomain? { get set }
}
