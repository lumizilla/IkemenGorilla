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
    let numberOfFans: Int
    let isFan: Bool
    let isVotedToday: Bool
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.id == rhs.id
    }
}
