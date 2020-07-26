//
//  Animal.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Animal: Entity {
    let id: String
    let name: String
    let iconUrl: String
    let sex: String
    let birthday: Date
    let description: String
    var numberOfFans: Int
    var isFan: Bool
    let zooName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, sex, birthday, description
        case iconUrl = "icon_url"
        case numberOfFans = "number_of_fans"
        case isFan = "is_fan"
        case zooName = "zoo_name"
    }
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.id == rhs.id
    }
}
