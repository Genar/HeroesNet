//
//  BoundTextField.swift
//  EamCoreUtils
//
//  Created by Genar Codina on 11/11/21.
//

import Foundation
import UIKit

public class BoundTextField: UITextField {
    
    public var changedClosure: (() -> ())?
    
    public func bind(to observable: Observable<String>) {
        
        addTarget(self, action: #selector(BoundTextField.valueChanged), for: .editingChanged)

        changedClosure = { [weak self] in
            observable.bindingChanged(to: self?.text ?? "")
        }

        observable.valueChanged = { [weak self] newValue in
            self?.text = newValue
        }
    }
    
    @objc func valueChanged() {
        
        changedClosure?()
    }
}
