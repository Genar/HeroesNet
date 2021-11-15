//
//  NetworkRequestService.swift
//  EamCoreServices
//
//  Created by Genar Codina on 11/11/21.
//

import Foundation

public enum SerializationError: Error {
  
  case missingData

  case dataCorrupted

  case keyNotFound

  case valueNotFound

  case typeMismatch

  case genericError(Error)
}

public final class NetworkRequestService: NetworkRequestServiceProtocol {

  typealias SerializationFunction<T> = (Data?, URLResponse?, Error?) -> Result<T, Error>

  public var defaultSession: URLSession

  public var sessionConfig: URLSessionConfiguration

  public init() {
     
      sessionConfig = URLSessionConfiguration.default
      defaultSession = URLSession(configuration: sessionConfig)
  }
    
  // MARK: - Public methods

  public func request<T: Decodable>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
      
    return request(url, serializationFunction: serializeJSON, completion: completion)
  }
    
  // MARK: - Private methods

  private func request<T>(_ url: URL, serializationFunction: @escaping SerializationFunction<T>,
                          completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
      
    let dataTask = defaultSession.dataTask(with: url) { data, response, error in
        let result: Result<T, Error> = serializationFunction(data, response, error)
        DispatchQueue.main.async {
            completion(result)
        }
    }
    dataTask.resume()

    return dataTask
  }

  private func serializeJSON<T: Decodable>(with data: Data?, response: URLResponse?, error: Error?) -> Result<T, Error> {
      
    if let error = error {
      return .failure(error)
    }
    guard let data = data else { return .failure(SerializationError.missingData) }
    do {
        let serializedValue = try JSONDecoder().decode(T.self, from: data)
        return .success(serializedValue)
    } catch let DecodingError.dataCorrupted(context) {
      print(context)
      return .failure(SerializationError.dataCorrupted)
    } catch let DecodingError.keyNotFound(key, context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return .failure(SerializationError.keyNotFound)
    } catch let DecodingError.valueNotFound(value, context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return .failure(SerializationError.valueNotFound)
    } catch let DecodingError.typeMismatch(type, context) {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
      return .failure(SerializationError.typeMismatch)
    } catch {
        print("error: ", error)
      return .failure(SerializationError.genericError(error))
    }
  }
}
