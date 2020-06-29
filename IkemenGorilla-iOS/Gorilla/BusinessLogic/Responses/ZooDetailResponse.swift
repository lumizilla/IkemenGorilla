//
//  ZooDetailResponse.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct ZooDetail: Codable {
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let imageUrl: String
    let description: String
    var isFavorite: Bool
    let numberOfFavorites: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, latitude, longitude, description
        case imageUrl = "image_url"
        case isFavorite = "is_favorite"
        case numberOfFavorites = "number_of_favorites"
    }
}
