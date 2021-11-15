//
//  NetworkRequestTests.swift
//  HeroesNetTests
//
//  Created by Genar Codina on 10/11/21.
//

import XCTest
@testable import EamCoreServices

class NetworkRequestTests: XCTestCase {
    
  var requestService: NetworkRequestServiceProtocol? // SUT
  
  var mockUrlSession: URLSessionMock?

  override func setUp() {
    
    super.setUp()
      
    requestService = NetworkRequestService()
    mockUrlSession = URLSessionMock()
  }

  override func tearDown() {
      
    mockUrlSession = nil
    requestService = nil
    
    super.tearDown()
  }
    
  // swiftlint:disable force_try
  func testRequest() {
      
    requestService?.defaultSession = mockUrlSession!
    let dummyEntity = DummyModel(name: "hi")
    let data = try! JSONEncoder().encode(dummyEntity)
    mockUrlSession?.data = data

    // Create a URL
    let url = URL(fileURLWithPath: "dummyurl")

    // Perform the request and verify the result
    _ = requestService!.request(url) { (result: Result<DummyModel, Error>) in
      switch result {
      case .success(let data):
          XCTAssertEqual("hi", data.name)
      case .failure(let error):
          XCTFail(error.localizedDescription)
      }
    }
  }
  
  // swiftlint:disable empty_enum_arguments
  func testRequestFail() {
      
    requestService?.defaultSession = mockUrlSession!
    let dummyEntity = DummyModelNotCodable(name: "hi")
    let data = encode(value: dummyEntity)
    mockUrlSession?.data = data as Data

    // Create a URL
    let url = URL(fileURLWithPath: "dummyurl")

    // Perform the request and verify the result
    _ = requestService!.request(url) { (result: Result<DummyModel, Error>) in
      switch result {
      case .success( _):
          XCTFail("Must not success")
      case .failure( _):
          XCTAssertTrue(true)
      }
    }
  }
}

func encode<T>( value: T) -> NSData {
    
  return withUnsafePointer(to: value) { ptr in
    NSData(bytes: ptr, length: MemoryLayout.size(ofValue: value))
  }
}

func decode<T>(data: NSData) -> T {
    
  let capacity = MemoryLayout.size(ofValue: T.self)
  let pointer = UnsafeMutablePointer<T>.allocate(capacity: capacity)
  data.getBytes(pointer, length: capacity)
  return pointer.move()
}
