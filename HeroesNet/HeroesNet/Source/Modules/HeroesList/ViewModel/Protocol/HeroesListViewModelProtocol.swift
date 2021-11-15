//
//  HeroesListViewModelProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import CoreData

protocol HeroesListViewModelProtocol {
    
  var showHeroes: (([IndexPath]) -> ())? { get set }
  
  var enableUserInteraction: ((Bool) -> ())? { get set }

  var heroes: [HeroEntity] { get set }

  /// To perform an action when the user selects an item of the table
  var coordinatorDelegate: HeroesListViewModelCoordinatorDelegate? { get set }

  var warningsInfo: WarningsInfo { get set }

  func numberOfRowsInSection(section: Int) -> Int

  func showDetail(heroInfo: HeroEntity)

  func isConnectionOn() -> Bool

  func viewDidLoad()
  
  func willEnterForeground()
  
  func loadMoreItems()
}
