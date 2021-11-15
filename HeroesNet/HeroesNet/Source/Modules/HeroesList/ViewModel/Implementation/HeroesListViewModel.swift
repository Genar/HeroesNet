//
//  HeroesListViewModel.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import Network
import EamCoreUtils
import EamDomain

enum HeroViewModelConstants {
  
  static let noInternetConnection: String = "no_internet_connection"
}

class HeroesListViewModel: HeroesListViewModelProtocol {

  /// Limit of items to get from the webservice
  let limit = 20
  
  /// Offset for the tems to get from the webservice
  var offset = 0
  
  weak var coordinatorDelegate: HeroesListViewModelCoordinatorDelegate?
  
  private let heroesUseCase: HeroesUseCaseProtocol
  
  private let isConnectionOnUseCase: IsConnectionOnUseCaseProtocol
  
  private let startNetworkMonitoringUseCase: StartNetworkMonitoringUseCaseProtocol
  
  var showHeroes: (([IndexPath]) -> ())?
  
  var enableUserInteraction: ((Bool) -> ())?
  
  var heroes: [HeroDomain] = []
  
  var warningsInfo = WarningsInfo(info: Observable(""))
  
  init(heroesUseCase: HeroesUseCaseProtocol,
       isConnectionOnUseCase: IsConnectionOnUseCaseProtocol,
       startNetworkMonitoringUseCase: StartNetworkMonitoringUseCaseProtocol) {
      
    self.heroesUseCase = heroesUseCase
    self.isConnectionOnUseCase = isConnectionOnUseCase
    self.startNetworkMonitoringUseCase = startNetworkMonitoringUseCase
  }
  
  func viewDidLoad() {
    
    getHeroes()
    enableUserInteraction?(false)
  }
  
  func willEnterForeground() {
    
    if heroes.isEmpty {
      getHeroes()
    }
  }
  
  func numberOfRowsInSection(section: Int) -> Int {
    
    return heroes.count
  }
  
  func showDetail(indexPath: IndexPath) {
    
    let hero = heroes[indexPath.row]
    coordinatorDelegate?.showDetail(heroInfo: hero)
  }
  
  func isConnectionOn() -> Bool {
    
    return self.isConnectionOnUseCase.execute()
  }
  
  func loadMoreItems() {
    
    let isConnectionOk = isConnectionOn()
    if isConnectionOk {
      self.showWarningsInfo(info: "")
      offset += limit
      self.enableUserInteraction?(false)
      self.getHeroesFromWebService(limit: limit, offset: offset)
    } else {
      self.showWarningsInfo(info: HeroViewModelConstants.noInternetConnection.localized)
    }
  }
  
  func getCellInfo(indexPath: IndexPath) -> HeroDomain {
    
    let hero = heroes[indexPath.row]
    let heroDescription = hero.description.isEmpty ? HeroItemStrings.noDescriptionAvailable.localized : hero.description
    let heroItem = HeroDomain(id: hero.id,
                              name: hero.name,
                              description: heroDescription,
                              numSeries: String(format: HeroItemStrings.numberOfSeries.localized,
                                                hero.numSeries),
                              numComics: String(format: HeroItemStrings.numberOfSeries.localized,
                                                hero.numComics),
                              numEvents: String(format: HeroItemStrings.numberOfEvents.localized,
                                                hero.numEvents),
                              numStories: String(format: HeroItemStrings.numberOfSeries.localized,
                                                 hero.numStories),
                              thumbnailUrl: hero.thumbnailUrl,
                              image: hero.image,
                              url: hero.url)
    
    return heroItem
  }
  
  func renderImage(index: Int, completion: @escaping ((Data) -> Void)) {
    
    let heroItem = heroes[index]
    guard let imageUrl = heroItem.thumbnailUrl else { return }
    NetworkUtils.downloadImage(from: imageUrl) { (data, response, error) in
      guard let data = data, let _ = response, error == nil else { return }
      self.heroes[index].image = data
      completion(data)
    }
  }
  
  func getWarningInfo() -> Observable<String> {
    
    self.warningsInfo.info
  }
  
  private func getHeroes() {
    
    let isConnectionOk = isConnectionOn()
    if isConnectionOk {
      self.showWarningsInfo(info: "")
      getHeroesFromWebService(limit: limit, offset: offset)
    } else {
      self.showWarningsInfo(info: HeroViewModelConstants.noInternetConnection.localized)
    }
  }
  
  private func showWarningsInfo(info: String) {
    DispatchQueue.main.async {
      self.warningsInfo.info.value = info
    }
  }
  
  private func setNetworkMonitoring() {
      
      let pathUpdateHandler: ((NWPath) -> Void )? = { [weak self] path in
          guard let self = self else { return }
          if path.status != .satisfied {
            self.showWarningsInfo(info: HeroViewModelConstants.noInternetConnection.localized)
          }
      }
    startNetworkMonitoringUseCase.execute(pathUpdateHandler: pathUpdateHandler)
  }
  
  private func getHeroesFromWebService(limit: Int, offset: Int) {

    self.heroesUseCase.execute(limit: limit, offset: offset) { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let heroes):
        let areNumberOfItemsEqualToLimit = heroes.count == limit
        let numItemsToAdd: Int = (areNumberOfItemsEqualToLimit) ? limit : heroes.count
        let indexPathArray: [IndexPath] = (0..<numItemsToAdd)
          .map { idx in IndexPath(row: offset + idx, section: 0)}
        self.heroes += heroes
        self.showHeroes?(indexPathArray)
      case .failure(let networkError):
        self.showWarningsInfo(info: networkError.localizedDescription)
      }
      self.enableUserInteraction?(true)
    }
  }
  
}
