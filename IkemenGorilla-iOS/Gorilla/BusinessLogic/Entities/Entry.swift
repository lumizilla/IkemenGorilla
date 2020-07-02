//
//  Entry.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Entry: Entity {
    let animalId: String
    let name: String
    let iconUrl: String
    let zooName: String
    
    enum CodingKeys: String, CodingKey {
        case animalId = "animal_id"
        case name
        case iconUrl = "icon_url"
        case zooName = "zoo_name"
    }
    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.animalId == rhs.animalId
    }
}
