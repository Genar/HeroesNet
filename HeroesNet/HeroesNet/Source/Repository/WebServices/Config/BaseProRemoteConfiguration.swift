//
//  BaseProRemoteConfiguration.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import EamCoreServices

public class BaseProRemoteConfiguration: BaseRemoteConfigurationProtocol {
    
    // MARK: - Base URL
    
    public var baseUrl: String = "http://gateway.marvel.com/"
    
    public init() {}
}
