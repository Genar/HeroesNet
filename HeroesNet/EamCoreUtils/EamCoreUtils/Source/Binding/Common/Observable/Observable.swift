//
//  Observable.swift
//  EamCoreUtils
//
//  Created by Genar Codina on 11/11/21.
//

import Foundation

public class Observable<ObservedType> {
    
    private var _value: ObservedType?
    
    var valueChanged: ((ObservedType?) -> ())?

    public init(_ value: ObservedType) {
        _value = value
    }
    
    public var value: ObservedType? {
        get {
            return _value
        }

        set {
            _value = newValue
            valueChanged?(_value)
        }
    }
    
    func bindingChanged(to newValue: ObservedType) {
        
        _value = newValue
    }
}
