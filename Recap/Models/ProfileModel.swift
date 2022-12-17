//
//  ProfileModel.swift
//  Recap
//
//  Created by Kaylee Williams on 17/12/2022.
//

import Foundation
import SwiftUI

struct ProfileModel: Codable {
    let displayName: String?
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href: String?
    let id: String?
    let images: [ItemImage]?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case followers, href, id, images, type, uri
    }
}
