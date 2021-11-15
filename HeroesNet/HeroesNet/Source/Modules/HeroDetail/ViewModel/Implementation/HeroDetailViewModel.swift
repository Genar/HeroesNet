//
//  HeroDetailViewModel.swift
//  HeroesNet
//
//  Created by Genar Codina on 9/11/21.
//

import Foundation

class HeroDetailViewModel: HeroDetailViewModelProtocol {

  weak var coordinatorDelegate: HeroDetailViewModelCoordinatorDelegate?
  
  let repository: RepositoryProtocol
  
  var heroInfo: HeroEntity?
  
  var showHero: ((HeroEntity) -> ())?
  
  var enableAnimation: ((Bool) -> ())?
  
  init(repository: RepositoryProtocol) {
      
      self.repository = repository
  }
  
  // MARK: - Public methods
  
  func viewWillAppear() {
  
    let isConnectionOk = isConnectionOn()
    if !isConnectionOk {
      print("Connection KO")
    }
    
    guard let heroInfo = self.heroInfo else { return }
    showHero?(heroInfo)
    enableAnimation?(true)
  }
    
  func isConnectionOn() -> Bool {
      
    return repository.isNetworkOn()
  }
  
  func stopAnimation() {
    
    enableAnimation?(false)
  }
}
