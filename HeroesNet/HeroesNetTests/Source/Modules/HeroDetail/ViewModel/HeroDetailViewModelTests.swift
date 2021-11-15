//
//  HeroDetailViewModelTests.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 10/11/21.
//

import XCTest
@testable import HeroesNet
import EamDomain

class HeroDetailViewModelTests: XCTestCase {
  
  var sut: HeroDetailViewModel?
  
  var isConnectionOnUseCase: IsConnectionOnUseCaseProtocol?

  override func setUp() {
    
    super.setUp()
    
    isConnectionOnUseCase = IsConnectionOnUseCaseMock()
    sut = HeroDetailViewModel(isConnectionOnUseCase: isConnectionOnUseCase!)
  }

  override func tearDown() {
    
    super.tearDown()
  }
    
  func testIsConnectionOn() {
    
    if let isConnectionOnUseCase = self.isConnectionOnUseCase {
      let isConnectionOn = isConnectionOnUseCase.execute()
      XCTAssertTrue(isConnectionOn)
    } else {
      XCTFail("isConnectionOnUseCase is nil")
    }
  }
  
  func testStopAnimationIsTrue() {
    
    let view = HeroDetailViewControllerMock()
    view.viewModel = sut
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
