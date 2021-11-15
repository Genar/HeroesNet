//
//  HeroesListViewModelCoordinatorDelegate.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import UIKit

protocol HeroesListViewModelCoordinatorDelegate: AnyObject {
    
    func showDetail(heroInfo: HeroEntity)
}
