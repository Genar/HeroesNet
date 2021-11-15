//
//  HeroDetailViewModelProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import EamCoreUtils
import EamDomain

protocol HeroDetailViewModelProtocol {
  
  var showHero: (() -> ())? { get set }
  
  var heroInfo: HeroDomain? { get set }
  
  var enableAnimation: ((Bool) -> ())? { get set }
    
  var coordinatorDelegate: HeroDetailViewModelCoordinatorDelegate? { get set }

  func viewWillAppear()
  
  func isConnectionOn() -> Bool
  
  func stopAnimation()
  
  func getHeroUrlInfo() -> URL?
  
  func getHeroInfo() -> HeroDomain
}
