//
//  HeroesListViewModelProtocol.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import EamCoreUtils
import EamDomain

protocol HeroesListViewModelProtocol {
    
  var showHeroes: (([IndexPath]) -> ())? { get set }
  
  var enableUserInteraction: ((Bool) -> ())? { get set }

  /// To perform an action when the user selects an item of the table
  var coordinatorDelegate: HeroesListViewModelCoordinatorDelegate? { get set }

  // var warningsInfo: WarningsInfo { get set }

  func numberOfRowsInSection(section: Int) -> Int

  func showDetail(indexPath: IndexPath)

  func isConnectionOn() -> Bool

  func viewDidLoad()
  
  func willEnterForeground()
  
  func loadMoreItems()
  
  func getCellInfo(indexPath: IndexPath) -> HeroDomain
  
  func renderImage(index: Int, completion: @escaping ((Data) -> Void))
  
  func getWarningInfo() -> Observable<String>
}
