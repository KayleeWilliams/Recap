//
//  ProfileModel.swift
//  Recap
//
//  Created by Kaylee Williams on 17/12/2022.
//

import Foundation
import SwiftUI

struct ProfileModel: Codable {
    let country, displayName, email: String?
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href: String?
    let id: String?
    let product, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case email
        case externalUrls = "external_urls"
        case followers, href, id, product, type, uri
    }
}
