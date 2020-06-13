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
}
