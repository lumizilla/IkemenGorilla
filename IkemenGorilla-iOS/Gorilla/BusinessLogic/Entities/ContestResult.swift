//
//  ContestResult.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct ContestResult: Entity {
    let animalId: String
    let animalName: String
    let iconUrl: String
    let numberOfVotes: Int
    let maxOfVotes: Int
    
    enum CodingKeys: String, CodingKey {
        case animalId = "animal_id"
        case animalName = "animal_name"
        case iconUrl = "icon_url"
        case numberOfVotes = "number_of_votes"
        case maxOfVotes = "max_of_votes"
    }
    
    static func == (lhs: ContestResult, rhs: ContestResult) -> Bool {
        return lhs.animalId == rhs.animalId
    }
}
