//
//  Award.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Award: Entity {
    let animalId: String
    let animalName: String
    let iconUrl: String
    let awardName: String
    
    enum CodingKeys: String, CodingKey {
        case animalId = "animal_id"
        case animalName = "animal_name"
        case iconUrl = "icon_url"
        case awardName = "award_name"
    }
    
    static func == (lhs: Award, rhs: Award) -> Bool {
        return lhs.animalId == rhs.animalId
    }
}
