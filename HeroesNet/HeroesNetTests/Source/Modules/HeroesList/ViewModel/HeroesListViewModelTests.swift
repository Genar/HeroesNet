//
//  HeroesListViewModelTests.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 10/11/21.
//

import XCTest
@testable import HeroesNet

class HeroesListViewModelTests: XCTestCase {
  
  var repository: RepositoryProtocol?
  
  var sut: HeroesListViewModel?

  override func setUp() {
    
    super.setUp()
    
    repository = RepositoryMock()
    
    sut = HeroesListViewModel(repository: repository!)
  }

  override func tearDown() {
    
    repository = nil
    
    super.tearDown()
  }
  
  func testviewDidLoadLoadsTwoItems() {

    // RepositoryMock returns two items
    sut?.viewDidLoad()
    let numberOfHeroes = sut?.heroes.count ?? 0
    XCTAssertEqual(numberOfHeroes, 2)
  }
  
  func testNumberOfRowsInSectionIsTwo() {
    
    // RepositoryMock returns two items
    sut?.viewDidLoad()
    let numberRowsInSection = sut?.numberOfRowsInSection(section: 0) ?? 0
    XCTAssertEqual(numberRowsInSection, 2)
  }
  
  func testViewDidLoadSetsConnectionOn() {
  
    sut?.viewDidLoad()
    XCTAssertTrue(sut!.isConnectionOn())
  }
  
  func testLoadMoreItemsSetsTwoItems() {
    
    // RepositoryMock returns two items
    sut?.loadMoreItems()
    let numberOfHeroes = sut?.heroes.count ?? 0
    XCTAssertEqual(numberOfHeroes, 2)
  }
  
  func testWillEnterForegroundSetsTwoItems() {
    
    // RepositoryMock returns two items
    sut?.willEnterForeground()
    let numberRowsInSection = sut?.numberOfRowsInSection(section: 0) ?? 0
    XCTAssertEqual(numberRowsInSection, 2)
  }
}
