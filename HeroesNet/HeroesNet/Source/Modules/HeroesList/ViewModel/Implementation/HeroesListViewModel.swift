//
//  HeroesListViewModel.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import Network
import EamCoreUtils

private enum HeroListViewModelConstants {
  
  static let noInternetConnection: String = "no_internet_connection"
}

class HeroesListViewModel: HeroesListViewModelProtocol {
  
  /// Limit of items to get from the webservice
  let limit = 20
  
  /// Offset for the tems to get from the webservice
  var offset = 0
  
  weak var coordinatorDelegate: HeroesListViewModelCoordinatorDelegate?

  private let repository: RepositoryProtocol
  
  var showHeroes: (([IndexPath]) -> ())?
  
  var enableUserInteraction: ((Bool) -> ())?
  
  var heroes: [HeroEntity] = []
  
  var warningsInfo = WarningsInfo(info: Observable(""))
  
  init(repository: RepositoryProtocol) {
      
      self.repository = repository
  }
  
  func viewDidLoad() {
    
    getHeroes()
    
    setNetworkMonitoring()
    
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
  
  func showDetail(heroInfo: HeroEntity) {
    
    coordinatorDelegate?.showDetail(heroInfo: heroInfo)
  }
  
  func isConnectionOn() -> Bool {
    
    return repository.isNetworkOn()
  }
  
  func loadMoreItems() {
    
    let isConnectionOk = isConnectionOn()
    if isConnectionOk {
      self.showWarningsInfo(info: "")
      offset += limit
      self.enableUserInteraction?(false)
      self.getHeroesFromWebService(limit: limit, offset: offset)
    } else {
      self.showWarningsInfo(info: HeroListViewModelConstants.noInternetConnection.localized)
    }
  }
  
  private func getHeroes() {
    
    let isConnectionOk = isConnectionOn()
    if isConnectionOk {
      self.showWarningsInfo(info: "")
      getHeroesFromWebService(limit: limit, offset: offset)
    } else {
      self.showWarningsInfo(info: HeroListViewModelConstants.noInternetConnection.localized)
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
          if path.status == .satisfied {
              print("----We are connected!")
          } else {
              print("----No internet connection.")
              self.showWarningsInfo(info: HeroListViewModelConstants.noInternetConnection.localized)
          }
          print(path.isExpensive)
      }
      repository.startNetworkMonitoring(pathUpdateHandler: pathUpdateHandler)
  }
  
  private func getHeroesFromWebService(limit: Int, offset: Int) {

    self.repository.getHeroes(limit: limit, offset: offset) { [weak self] result in
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
