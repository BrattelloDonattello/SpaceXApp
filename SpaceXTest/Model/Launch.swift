//
//  Launch.swift
//  SpaceXTest
//
//  Created by Cristian Ciupac on 15.09.2022.
//

import Foundation

struct Launch : Codable, Identifiable {
    let links : Links?
    let rocket : String
    let details : String?
    let name : String
    let date_utc : String
    let upcoming : Bool
    let id : String

    enum CodingKeys: String, CodingKey {
        case links = "links"
        case rocket = "rocket"
        case details = "details"
        case name = "name"
        case date_utc = "date_utc"
        case upcoming = "upcoming"
        case id = "id"
    }
}

struct Links: Codable {
    let patch: Patch
    let flicker: Flicker
    let youtube_id: String?
    let wikipedia: String?
    
    enum CodingKeys: String, CodingKey {
        case patch = "patch"
        case flicker = "flickr"
        case youtube_id = "youtube_id"
        case wikipedia = "wikipedia"
    }
}

struct Patch: Codable {
    let small: String?
    let large: String?
    
    enum CodingKeys: String, CodingKey {
        case small = "small"
        case large = "large"
    }
}

struct Flicker: Codable {
    let small: [String?]
    let original: [String?]
    
    enum CodingKeys: String, CodingKey {
        case small = "small"
        case original = "original"
    }
}
