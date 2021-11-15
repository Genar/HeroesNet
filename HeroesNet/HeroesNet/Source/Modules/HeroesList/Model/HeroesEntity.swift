//
//  HeroesEntity.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation

// MARK: - Heroes
struct HeroesEntity: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: HeroesInfo?
}

// MARK: - DataClass
struct HeroesInfo: Codable {
    let offset, limit, total, count: Int?
    let results: [HeroEntity]?
}
