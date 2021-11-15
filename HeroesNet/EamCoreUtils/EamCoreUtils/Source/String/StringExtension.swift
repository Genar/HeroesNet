//
//  StringExtension.swift
//  EamCoreUtils
//
//  Created by Genar Codina on 11/11/21.
//

import Foundation

extension String {

    public var localized: String {
        
        return NSLocalizedString(self, comment: "\(self)_comment")
    }

    public func localized(_ args: CVarArg...) -> String {
        
        return String(format: localized, args)
    }
}

extension String {
    
    public func numberOfOccurrencesOf(string: String) -> Int {
        
        return self.components(separatedBy: string).count - 1
    }
}
