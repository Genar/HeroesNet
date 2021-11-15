//
//  HeroesUseCaseTests.swift
//  EamDomainTests
//
//  Created by Genar Codina on 18/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import XCTest
@testable import EamDomain

class HeroesUseCaseTests: XCTestCase {
  
  var sut: HeroesUseCaseProtocol?
  
  var heroesProvider: HeroesProviderProtocol?
  
  var heroesProviderFailure: HeroesProviderFailureMock?

  override func setUp() {
    
    super.setUp()
  }

  override func tearDown() {
    
    sut = nil
    super.tearDown()
  }

  func testExecuteSuccessGivesDaredevil() {
    
    let heroProvider = HeroesProviderMock()
    sut = HeroesUseCase(provider: heroProvider)
    
    sut?.execute(limit: 1, offset: 1, completion: { result in
      if case let .success(heroes) = result {
        XCTAssertEqual(heroes.count, 2)
        XCTAssertEqual(heroes[0].name, "Daredevil")
      } else {
        XCTFail("HeroesUseCase execute success fail")
      }
    })
  }
  
  func testExecuteFailureGivesStatusCodeNotOk() {
    
    let heroProvider = HeroesProviderFailureMock()
    sut = HeroesUseCase(provider: heroProvider)
    
    sut?.execute(limit: 1, offset: 1, completion: { result in
      if case let .failure(error) = result {
        XCTAssertNotNil(error)
      } else {
        XCTFail("HeroesUseCase execute failure fail")
      }
    })
  }
}
