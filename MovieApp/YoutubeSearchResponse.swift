//
//  YoutubeSearchResponse.swift
//  MovieApp
//
//  Created by MacMini on 20/12/25.
//

import Foundation
struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
}
