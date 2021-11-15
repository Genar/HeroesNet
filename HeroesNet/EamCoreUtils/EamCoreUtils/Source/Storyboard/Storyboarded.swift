//
//  Storyboarded.swift
//  EamCoreUtils
//
//  Created by Genar Codina on 11/11/21.
//

import UIKit

public protocol Storyboarded {
    
    static func instantiate(storyBoardName: String) -> Self?
}

public extension Storyboarded where Self: UIViewController {
  
  static func instantiate(storyBoardName: String) -> Self? {
    
    let className = String(describing: self)
    
    let bundle = Bundle(for: self)

    let storyboard = UIStoryboard(name: storyBoardName, bundle: bundle)

    return storyboard.instantiateViewController(withIdentifier: className) as? Self
  }
}
