//
//  HeroEntity.swift
//  HeroesNet
//
//  Created by Genar Codina on 8/11/21.
//

import Foundation
import UIKit
import EamDomain

enum DataConvertionError: Error {
  
  case invalidParameters
}

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
  
  func convertToDomain() throws -> HeroDomain {
    
    guard let id = id, let name = name else { throw DataConvertionError.invalidParameters }
    
    let heroDomain = HeroDomain(id: id,
                                name: name,
                                description: resultDescription ?? "",
                                numSeries: String(series?.available ?? 0),
                                numComics: String(comics?.available ?? 0),
                                numEvents: String(events?.available ?? 0),
                                numStories: String(stories?.available ?? 0),
                                thumbnailUrl: thumbnail?.convertToDomain(),
                                image: nil,
                                url: urls?[0].convertToDomain())
    
    return heroDomain
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
  
  func convertToDomain() -> URL? {
    
    guard let path = path, let thumbnailExtension = thumbnailExtension else { return nil }
    guard let url = URL(string: "\(String(describing: path)).\(String(describing: thumbnailExtension))") else { return nil }
    
    return url
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
  
  func convertToDomain() -> URL? {
    
    guard let url = self.url else { return nil }
    guard let url = URL(string: url) else { return nil }
    return url
  }
}

enum URLType: String, Codable {
  case comiclink = "comiclink"
  case detail = "detail"
  case wiki = "wiki"
}
