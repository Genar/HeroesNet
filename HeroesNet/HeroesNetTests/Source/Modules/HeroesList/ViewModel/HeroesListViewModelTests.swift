//
//  HeroesListViewModelTests.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 10/11/21.
//

import XCTest
import EamDomain
@testable import HeroesNet

class HeroesListViewModelTests: XCTestCase {
  
  var isConnectionOnUseCase: IsConnectionOnUseCaseProtocol!
  
  var sut: HeroesListViewModel!

  override func setUp() {
    
    super.setUp()
    
    let heroesUseCase = HeroesUseCaseMock()
    let isConnectionOnUseCase = IsConnectionOnUseCaseMock()
    let startNetworkMonitoringUseCase =  StartNetworkMonitoringUseCaseMock()
    
    sut = HeroesListViewModel(heroesUseCase: heroesUseCase,
                              isConnectionOnUseCase: isConnectionOnUseCase,
                              startNetworkMonitoringUseCase: startNetworkMonitoringUseCase)
  }

  override func tearDown() {
    
    super.tearDown()
  }
  
  func testviewDidLoadLoadsTwoItems() {

    // HeroesUseCaseMock returns two items
    sut?.viewDidLoad()
    let numberOfHeroes = sut?.heroes.count ?? 0
    XCTAssertEqual(numberOfHeroes, 2)
  }
  
  func testNumberOfRowsInSectionIsTwo() {
    
    // HeroesUseCaseMockck returns two items
    sut?.viewDidLoad()
    let numberRowsInSection = sut?.numberOfRowsInSection(section: 0) ?? 0
    XCTAssertEqual(numberRowsInSection, 2)
  }
  
  func testViewDidLoadSetsConnectionOn() {
  
    sut?.viewDidLoad()
    XCTAssertTrue(sut!.isConnectionOn())
  }
  
  func testLoadMoreItemsSetsTwoItems() {
    
    // HeroesUseCaseMock returns two items
    sut?.loadMoreItems()
    let numberOfHeroes = sut?.heroes.count ?? 0
    XCTAssertEqual(numberOfHeroes, 2)
  }
  
  func testWillEnterForegroundSetsTwoItems() {
    
    // HeroesUseCaseMock returns two items
    sut?.willEnterForeground()
    let numberRowsInSection = sut?.numberOfRowsInSection(section: 0) ?? 0
    XCTAssertEqual(numberRowsInSection, 2)
  }
}
