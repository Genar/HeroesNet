//
//  HeroUseCaseTests.swift
//  EamDomainTests
//
//  Created by Genar Codina on 18/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import XCTest
@testable import EamDomain

class HeroUseCaseTests: XCTestCase {
  
  var sut: HeroUseCaseProtocol?
  
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
    sut = HeroUseCase(provider: heroProvider)
    
    sut?.execute(code: 1, completion: { result in
      if case let .success(hero) = result {
        XCTAssertEqual(hero.name, "Daredevil")
      } else {
        XCTFail("HeroUseCase execute success fail")
      }
    })
  }
  
  func testExecuteFailureGivesStatusCodeNotOk() {
    
    let heroProvider = HeroesProviderFailureMock()
    sut = HeroUseCase(provider: heroProvider)
    
    sut?.execute(code: 1, completion: { result in
      if case let .failure(error) = result {
        XCTAssertNotNil(error)
      } else {
        XCTFail("HeroesUseCase execute failure fail")
      }
    })
  }
}
