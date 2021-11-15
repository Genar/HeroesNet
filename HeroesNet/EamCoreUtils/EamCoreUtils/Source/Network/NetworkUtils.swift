//
//  NetworkUtils.swift
//  EamCoreUtils
//
//  Created by Genar Codina on 11/11/21.
//

import Foundation

public typealias NetworkUtilsCompletionHandler = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

public enum NetworkUtils {

    private static func getData(from url: URL, completion: @escaping NetworkUtilsCompletionHandler) {
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    public static func downloadImage(from url: URL, completion: @escaping NetworkUtilsCompletionHandler) {
        
        getData(from: url) { data, response, error in
            guard let data = data, let response = response, error == nil else { return }
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }
    }
}
