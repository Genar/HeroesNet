//
//  HeroDetailProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation

protocol HeroDetailCoordinatorProtocol: AnyObject {
    
    var heroInfo: HeroEntity? { get set }
}
