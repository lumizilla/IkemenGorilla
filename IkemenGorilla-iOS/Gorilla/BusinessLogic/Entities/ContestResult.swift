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
    
    static func == (lhs: ContestResult, rhs: ContestResult) -> Bool {
        return lhs.animalId == rhs.animalId
    }
}
