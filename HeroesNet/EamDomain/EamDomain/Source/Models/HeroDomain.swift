//
//  HeroDomain.swift
//  HeroesNet
//
//  Created by Genar Codina on 15/11/21.
//  Copyright © 2021 Genar. All rights reserved.
//

import Foundation

public struct HeroDomain {
  
  public let id: Int
  public let name: String
  public let description: String
  public let numSeries: String
  public let numComics: String
  public let numEvents: String
  public let numStories: String
  public let thumbnailUrl: URL?
  public var image: Data?
  public var url: URL?
  
  public init(id: Int,
              name: String,
              description: String,
              numSeries: String,
              numComics: String,
              numEvents: String,
              numStories: String,
              thumbnailUrl: URL?,
              image: Data?,
              url: URL?) {
    
    self.id = id
    self.name = name
    self.description = description
    self.numSeries = numSeries
    self.numComics = numComics
    self.numEvents = numEvents
    self.numStories = numStories
    self.thumbnailUrl = thumbnailUrl
    self.image = image
    self.url = url
  }
}
