//
//  Zoo.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Zoo: Entity {
    let id: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, address, latitude, longitude
        case imageUrl = "image_url"
    }
    
    static func == (lhs: Zoo, rhs: Zoo) -> Bool {
        lhs.id == rhs.id
    }
}
