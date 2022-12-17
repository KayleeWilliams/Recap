//
//  PlaylistModel.swift
//  Recap
//
//  Created by Kaylee Williams on 17/12/2022.
//

import Foundation

struct PlaylistModel: Codable {
    let collaborative: Bool?
    let welcomeDescription: String?
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href: String?
    let id: String?
    let name: String?
    let welcomePublic: Bool?
    let snapshotID: String?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case collaborative
        case welcomeDescription = "description"
        case externalUrls = "external_urls"
        case followers, href, id, name
        case welcomePublic = "public"
        case snapshotID = "snapshot_id"
        case type, uri
    }
}

struct SnapshotModel: Codable {
    let snapshotID: String?

    enum CodingKeys: String, CodingKey {
        case snapshotID = "snapshot_id"
    }
}
