//
//  EndPoints.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation

class EndPoints: EndPointsProtocol {
    
    var heroes: String = "v1/public/characters?limit=%@&offset=%@&ts=%@&apikey=%@&hash=%@"
    
    var heroInfo: String = "v1/public/characters/%@?ts=%@&apikey=%@&hash=%@"
}
