//
//  HeroesListViewModelCoordinatorDelegate.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import UIKit
import EamDomain

protocol HeroesListViewModelCoordinatorDelegate: AnyObject {
    
    func showDetail(heroInfo: HeroDomain)
}
