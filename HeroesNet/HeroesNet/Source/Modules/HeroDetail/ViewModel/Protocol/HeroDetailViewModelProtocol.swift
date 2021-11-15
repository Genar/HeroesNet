//
//  HeroDetailViewModelProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation

protocol HeroDetailViewModelProtocol {
    
  var heroInfo: HeroEntity? { get set }
  
  var showHero: ((HeroEntity) -> ())? { get set }
  
  var enableAnimation: ((Bool) -> ())? { get set }
    
  var coordinatorDelegate: HeroDetailViewModelCoordinatorDelegate? { get set }

  func viewWillAppear()
  
  func isConnectionOn() -> Bool
  
  func stopAnimation()
}
