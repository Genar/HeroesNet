//
//  URLSessionFailureMock.swift
//  EamDataTests
//
//  Created by Genar Codina on 18/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation

enum NetworkErrorMock: Error {
  
  case badResponse
}

class URLSessionFailureMock: URLSession {
    
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

  // Properties that enable us to set exactly what data or error
  // we want our mocked URLSession to return for any request.
  var data: Data?
  var error: Error?

  override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
      
    let data = self.data
    _ = self.error
    
    let mockError = NetworkErrorMock.badResponse
    return URLSessionDataTaskMock {
        completionHandler(data, nil, mockError)
    }
  }
}
