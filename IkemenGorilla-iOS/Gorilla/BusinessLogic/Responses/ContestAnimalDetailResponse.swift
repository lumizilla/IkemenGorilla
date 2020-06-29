//
//  ContestAnimalDetailResponse.swift
//  Gorilla
//
//  Created by admin on 2020/06/12.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct ContestAnimalDetailResponse: Codable {
    let animalId: String
    let animalName: String
    let animalIconUrl: String
    let description: String
    let zooId: String
    let zooName: String
    let zooAddress: String
    let isVotedToday: Bool
    
    enum CodingKeys: String, CodingKey {
        case animalId = "animal_id"
        case animalName = "animal_name"
        case animalIconUrl = "animal_icon_url"
        case description
        case zooId = "zoo_id"
        case zooName = "zoo_name"
        case zooAddress = "zoo_address"
        case isVotedToday = "is_voted_today"
    }
}
