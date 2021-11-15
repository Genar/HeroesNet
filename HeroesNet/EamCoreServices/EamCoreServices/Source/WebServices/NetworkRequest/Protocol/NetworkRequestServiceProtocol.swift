//
//  NetworkRequestServiceProtocol.swift
//  EamCoreServices
//
//  Created by Genar Codina on 11/11/21.
//

import Foundation

public protocol NetworkRequestServiceProtocol {
    
    var defaultSession: URLSession { get set }
    
    var sessionConfig: URLSessionConfiguration { get set }
    
    /// Performs a network request
    /// - Parameters:
    ///   - url: target URL
    ///   - completion: completion handler
    func request<T: Decodable>(_ url: URL, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask
}
