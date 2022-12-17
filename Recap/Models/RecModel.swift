//
//  RecommendedSongsModel.swift
//  Recap
//
//  Created by Kaylee Williams on 17/12/2022.
//

import Foundation

struct RecModel: Codable {
    let tracks: [Track]?
    let seeds: [Seed]?
}

struct Seed: Codable {
    let initialPoolSize, afterFilteringSize, afterRelinkingSize: Int?
    let id, type: String?
    let href: String?
}
