//
//  ReachabilityServiceProtocol.swift
//  EamCoreServices
//
//  Created by Genar Codina on 11/11/21.
//

import Foundation
import Network

public protocol ReachabilityServiceProtocol {
    
    func isReachable() -> Bool
    
    func isNetworkReachable() -> Bool
    
    func isUsingWiFi() -> Bool
    
    func startNetworkMonitoring(pathUpdateHandler: ((NWPath) -> Void)?)
}
