//
//  HeroesProviderTests.swift
//  EamDataTests
//
//  Created by Genar Codina on 17/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import XCTest
@testable import EamData
import EamDomain
import EamCoreServices

class EamDataTests: XCTestCase {
  
  var sut: HeroesProviderProtocol?
  var mockUrlSession: URLSessionMock?
  var mockFailureUrlSession: URLSessionFailureMock?
  var requestService: NetworkRequestService?

  override func setUp() {
    
    let authConfig = AuthConfigMock()
    
    requestService = NetworkRequestService()
    
    let baseConfiguration = BaseConfigPro()
    
    let endPoints = EndPoints()
    
    sut = HeroesProvider(authConfig: authConfig,
                         baseConfig: baseConfiguration,
                         endPoints: endPoints,
                         requestService: requestService!)
    
    super.setUp()
  }

  override func tearDown() {
    
    mockUrlSession = nil
    sut = nil
    
    super.tearDown()
  }
  
  // MARK: - Characters Tests

  // swiftlint:disable force_try
  func testHeroesSuccessIsEqualToOne() {
    
    mockUrlSession = URLSessionMock()
    requestService!.defaultSession = mockUrlSession!
    
    let heroesEntity = setupOneHeroInHeroesEntity()
    
    let data = try! JSONEncoder().encode(heroesEntity)
    mockUrlSession?.data = data
    
    sut?.getHeroes(limit: 1, offset: 1, completion: { result in
      
      if case let .success(heroes) = result {
        XCTAssertEqual(heroes.count, 1)
      } else {
        XCTFail("No success")
      }
    })
  }
  
  // swiftlint:disable force_try
  func testHeroesFailure() {
    
    mockFailureUrlSession = URLSessionFailureMock()
    requestService!.defaultSession = mockFailureUrlSession!
    
    let heroesEntity = setupOneHeroInHeroesEntity()
    
    let data = try! JSONEncoder().encode(heroesEntity)
    mockUrlSession?.data = data
    
    sut?.getHeroes(limit: 1, offset: 1, completion: { result in
      
      if case let .success(error) = result {
        XCTAssertNotNil(error)
      } else {
        XCTFail("No success")
      }
    })
  }
  
  func testHeroSuccessIsEqualToDaredevil() {
    
    mockUrlSession = URLSessionMock()
    requestService!.defaultSession = mockUrlSession!
    
    let heroesEntity = setupOneHeroInHeroesEntity()
    
    let data = try! JSONEncoder().encode(heroesEntity)
    mockUrlSession?.data = data
    
    sut?.getHero(code: 1, completion: { result in
      
      if case let .success(hero) = result {
        XCTAssertEqual(hero.name, "Daredevil")
      } else {
        XCTFail("No success")
      }
    })
  }
  
  func testHeroFailure() {
    
    mockFailureUrlSession = URLSessionFailureMock()
    requestService!.defaultSession = mockFailureUrlSession!
    
    let heroesEntity = setupOneHeroInHeroesEntity()
    
    let data = try! JSONEncoder().encode(heroesEntity)
    mockUrlSession?.data = data
    
    sut?.getHero(code: 1, completion: { result in
      
      if case let .success(error) = result {
        XCTAssertNotNil(error)
      } else {
        XCTFail("No success")
      }
    })
  }
  
  private func setupOneHeroInHeroesEntity() -> HeroesEntity {
    
    let heroEntity = HeroEntity(id: 1,
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
    
    let heroesInfo = HeroesInfo(offset: 1, limit: 1, total: 1, count: 1, results: [heroEntity])
    
    let heroesEntity = HeroesEntity(code: 200,
                                    status: "OK",
                                    copyright: nil,
                                    attributionText: nil,
                                    attributionHTML: nil,
                                    etag: nil,
                                    data: heroesInfo)
    
    return heroesEntity
  }
  
}
