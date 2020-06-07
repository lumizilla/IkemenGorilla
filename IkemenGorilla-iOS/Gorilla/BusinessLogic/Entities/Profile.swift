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
    let likedId: String
    let likedIconUrl: String
    let likedZooId: String           //Not sure about this one, how to get the Zoo of the liked animal
    let likedZooName: String
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }
    
}
