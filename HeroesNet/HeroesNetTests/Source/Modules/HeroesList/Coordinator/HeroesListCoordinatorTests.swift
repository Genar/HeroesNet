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
import EamCoreUtils

class HeroesListCoordinatorTests: XCTestCase {
  
  var sut: (BaseCoordinatorProtocol & HeroesListViewModelCoordinatorDelegate)?

  override func setUp() {
    
    super.setUp()
    
    let repositoryMock = RepositoryMock()
    let navigationController = UINavigationController()
    sut = HeroesListCoordinator(navigationController: navigationController,
                                repository: repositoryMock)
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
    
    let hero = HeroEntity(id: 12345,
                          name: "Peter Parker",
                          resultDescription: nil,
                          modified: nil,
                          thumbnail: nil,
                          resourceURI: nil,
                          comics: nil,
                          series: nil,
                          stories: nil,
                          events: nil,
                          urls: nil,
                          image: nil)
    sut?.showDetail(heroInfo: hero)
    let childCoordinators = sut?.childCoordinators
    XCTAssertNotNil(childCoordinators)
    XCTAssertTrue(!(childCoordinators?.isEmpty ?? false))
    XCTAssertTrue((childCoordinators?.count == 1))
  }
}
