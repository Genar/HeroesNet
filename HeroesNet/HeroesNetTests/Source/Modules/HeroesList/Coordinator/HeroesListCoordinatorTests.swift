//
//  HeroesListCoordinatorTests.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 12/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import XCTest
import UIKit
@testable import HeroesNet
import EamDomain
import EamCoreUtils

class HeroesListCoordinatorTests: XCTestCase {
  
  var sut: (BaseCoordinatorProtocol & HeroesListViewModelCoordinatorDelegate)?

  override func setUp() {
    
    super.setUp()
    
    let navigationController = UINavigationController()
    let heroesUseCase = HeroesUseCaseMock()
    let isConnectionOnUseCase = IsConnectionOnUseCaseMock()
    let startNetworkMonitoringUseCase = StartNetworkMonitoringUseCaseMock()
    
    sut = HeroesListCoordinator(navigationController: navigationController,
                                heroesUseCase: heroesUseCase,
                                isConnectionOnUseCase: isConnectionOnUseCase,
                                startNetworkMonitoringUseCase: startNetworkMonitoringUseCase)
  }

  override func tearDown() {
    
    sut = nil

    super.tearDown()
  }
  
  func testStartSetsNavigationController() {
    
    sut?.start()
    XCTAssertNotNil(sut?.navigationController)
    
  }
  
  func testShowDetailSetsChildCoordinator() {
    
    let hero = HeroDomain(id: 12345,
                         name: "Ant-Man",
                         description: "Ant-Man description",
                         numSeries: "3",
                         numComics: "4",
                         numEvents: "5",
                         numStories: "6",
                         thumbnailUrl: nil,
                         image: nil,
                         url: nil)
    sut?.showDetail(heroInfo: hero)
    let childCoordinators = sut?.childCoordinators
    XCTAssertNotNil(childCoordinators)
    XCTAssertTrue(!(childCoordinators?.isEmpty ?? false))
    XCTAssertTrue((childCoordinators?.count == 1))
  }
}
