//
//  HeroDetailViewModel.swift
//  HeroesNet
//
//  Created by Genar Codina on 9/11/21.
//

import Foundation
import Network
import EamCoreUtils
import EamDomain

class HeroDetailViewModel: HeroDetailViewModelProtocol {
  
  weak var coordinatorDelegate: HeroDetailViewModelCoordinatorDelegate?
  
  let isConnectionOnUseCase: IsConnectionOnUseCaseProtocol
  
  var heroInfo: HeroDomain?
  
  var showHero: (() -> ())?
  
  var enableAnimation: ((Bool) -> ())?
  
  init(isConnectionOnUseCase: IsConnectionOnUseCaseProtocol) {
      
    self.isConnectionOnUseCase = isConnectionOnUseCase
  }
  
  // MARK: - Public methods
  
  func viewWillAppear() {
  
    showHero?()
    if isConnectionOn() {
      enableAnimation?(true)
    }
  }
  
  func isConnectionOn() -> Bool {
      
    return isConnectionOnUseCase.execute()
  }
  
  func stopAnimation() {
    
    enableAnimation?(false)
  }
  
  func getHeroUrlInfo() -> URL? {
    
    return heroInfo?.url
  }
  
  func getHeroInfo() -> HeroDomain {
    
    return HeroDomain(id: heroInfo?.id ?? 0,
                      name: heroInfo?.name ?? "",
                      description: heroInfo?.description ?? "",
                      numSeries: String(format: HeroItemStrings.numberOfSeries.localized,
                                        heroInfo?.numSeries ?? "0"),
                      numComics: String(format: HeroItemStrings.numberOfComics.localized,
                                        heroInfo?.numComics ?? "0"),
                      numEvents: String(format: HeroItemStrings.numberOfEvents.localized,
                                        heroInfo?.numEvents ?? "0"),
                      numStories: String(format: HeroItemStrings.numberOfStories.localized,
                                         heroInfo?.numStories ?? "0"),
                      thumbnailUrl: heroInfo?.thumbnailUrl,
                      image: heroInfo?.image,
                      url: heroInfo?.url)
  }
  
}
