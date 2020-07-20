//
//  FanAnimalResponse.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct FanAnimal: Codable {
    let id: String
    let name: String
    let iconUrl: String
    var isFan: Bool
    let zooName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case iconUrl = "icon_url"
        case zooName = "zoo_name"
        case isFan = "is_fan"
    }
}
