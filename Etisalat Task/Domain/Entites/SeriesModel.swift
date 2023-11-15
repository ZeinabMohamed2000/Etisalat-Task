//
//  SeriesModel.swift
//  Etisalat Task
//
//  Created by Zeinab on 14/11/2023.
//

import Foundation

// MARK: - Result
struct SeriesModel: Codable {
    let code: Int
    let status, copyright: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Series]
}

// MARK: - Series
struct Series: Codable {
    let id: Int
    let title, description: String?
//    let resourceURI: String
//    let urls: [URLElement]
      let startYear, endYear: Int
      let rating, type: String?
      let thumbnail: Thumbnail
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}
