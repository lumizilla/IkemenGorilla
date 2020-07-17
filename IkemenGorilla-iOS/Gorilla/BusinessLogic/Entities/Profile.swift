//
//  Profile.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Profile: Entity {
    let id: String
    let name: String
    let imageUrl: String
    let numberOfAnimals: Int
    let animalId: String
    let animalName: String
    let animalIconUrl: String
    let zooId: String
    let zooName: String
    let numberOfContests: Int
    let contestId: String
    let contestName: String
    let contestStart: Date
    let contestEnd: Date
    let contestIconUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, numberOfAnimals, numberOfContests, contestStart, contestEnd
        case imageUrl = "image_url"
        case animalId = "animal_id"
        case animalName = "animal_name"
        case animalIconUrl = "animal_icon_url"
        case zooId = "zoo_id"
        case zooName = "zoo_name"
        case contestId = "contest_id"
        case contestName = "contest_name"
        case contestIconUrl = "contest_icon_url"
    }
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }
    
}
