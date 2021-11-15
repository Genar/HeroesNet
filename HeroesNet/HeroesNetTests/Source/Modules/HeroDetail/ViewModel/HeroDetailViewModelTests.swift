//
//  HeroDetailViewModelTests.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 10/11/21.
//

import XCTest
@testable import HeroesNet

class HeroDetailViewModelTests: XCTestCase {
  
  var repository: RepositoryProtocol?
  
  var sut: HeroDetailViewModel?

  override func setUp() {
    
    super.setUp()
    
    repository = RepositoryMock()
    
    sut = HeroDetailViewModel(repository: repository!)
  }

  override func tearDown() {
    
    repository = nil
    
    super.tearDown()
  }
  
  func testViewWillAppear() {
    
    let hero = HeroEntity(id: 12345,
                          name: "Daredevil",
                          resultDescription: "Daredevil description",
                          modified: nil,
                          thumbnail: nil,
                          resourceURI: nil,
                          comics: nil,
                          series: nil,
                          stories: nil,
                          events: nil,
                          urls: nil,
                          image: nil)
    self.sut?.heroInfo = hero
    
    sut?.showHero = { hero in
      XCTAssertEqual(hero.id, 12345)
    }
    sut?.viewWillAppear()
  }
    
  func testIsConnectionOn() {
      
    let isConnectionOn = repository!.isNetworkOn()
    XCTAssertTrue(isConnectionOn)
  }
  
  func testStopAnimationIsTrue() {
    
    let view = HeroDetailViewControllerMock()
    view.viewModel = sut
    let hero = HeroEntity(id: 12345,
                          name: "Daredeveil",
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
    sut?.heroInfo = hero
    view.viewDidLoad()
    view.viewWillAppear(true)
    
    XCTAssertEqual(view.isAnimationEnabled, true)
  }
  
  func testStopAnimationIsFalse() {
    
    let view = HeroDetailViewControllerMock()
    view.viewModel = sut
    view.viewWillAppear(true)
    view.viewDidLoad()
    
    sut?.stopAnimation()
    XCTAssertEqual(view.isAnimationEnabled, false)
  }
}
