//
//  TrailerPlayback.swift
//  TenTwentyTask
//
//  Created by usama on 14/03/2022.
//

import Foundation

// MARK: - PlayBack
struct TrailerRoot: Codable {
    let id: Int
    let results: [Trailer]
}

// MARK: - Result
struct Trailer: Codable {
    let iso639_1, iso3166_1, name, key: String
    let publishedAt, site: String
    let size: Int
    let type: String
    let official: Bool
    let id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key
        case publishedAt = "published_at"
        case site, size, type, official, id
    }
}
