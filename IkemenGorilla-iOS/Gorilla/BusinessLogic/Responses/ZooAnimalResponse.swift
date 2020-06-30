//
//  ZooAnimalResponse.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct ZooAnimal: Codable {
    let id: String
    let name: String
    let iconUrl: String
    var isFan: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case iconUrl = "icon_url"
        case isFan = "is_fan"
    }
}
