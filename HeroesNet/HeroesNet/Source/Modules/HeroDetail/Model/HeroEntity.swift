//
//  HeroEntity.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import UIKit

// MARK: - Detail
struct HeroEntity: Codable {
  var id: Int?
  var name, resultDescription: String?
  var modified: String?
  var thumbnail: Thumbnail?
  var resourceURI: String?
  var comics, series: Comics?
  var stories: Stories?
  var events: Comics?
  var urls: [URLElement]?
  var image: Data?

  enum CodingKeys: String, CodingKey {
      case id, name
      case resultDescription = "description"
      case modified, thumbnail, resourceURI, comics, series, stories, events, urls
  }
}

// MARK: - Comics
struct Comics: Codable {
  let available: Int?
  let collectionURI: String?
  let items: [ComicsItem]?
  let returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
  let resourceURI: String?
  let name: String?
}

// MARK: - Stories
struct Stories: Codable {
  let available: Int?
  let collectionURI: String?
//  let items: [StoriesItem]?
  let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
  let resourceURI: String?
  let name: String?
  let type: ItemType?
}

enum ItemType: String, Codable {
  case cover = "cover"
  case empty = ""
  case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
  let path: String?
  let thumbnailExtension: Extension?

  enum CodingKeys: String, CodingKey {
      case path
      case thumbnailExtension = "extension"
  }
}

enum Extension: String, Codable {
  case gif = "gif"
  case jpg = "jpg"
  case png = "png"
}

// MARK: - URLElement
struct URLElement: Codable {
  let type: URLType?
  let url: String?
}

enum URLType: String, Codable {
  case comiclink = "comiclink"
  case detail = "detail"
  case wiki = "wiki"
}
