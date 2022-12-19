//
//  ArtistModel.swift
//  Recap
//
//  Created by Kaylee Williams on 14/12/2022.
//

import Foundation

struct ArtistsModel: Codable {
    let items: [Artist]?
    let total, limit, offset: Int?
    let href: String?
}

struct Artist: Identifiable, Codable, Hashable, Equatable {
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let genres: [String]?
    let href: String?
    let id: String?
    let images: [ItemImage]?
    let name: String?
    let popularity: Int?
    let type, uri: String?
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
    
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ExternalUrls: Codable {
    let spotify: String?
}

struct Followers: Codable {
    let href: String?
    let total: Int?
}

struct ItemImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct RelatedArtistsModel: Codable {
    let artists: [Artist]?
}
