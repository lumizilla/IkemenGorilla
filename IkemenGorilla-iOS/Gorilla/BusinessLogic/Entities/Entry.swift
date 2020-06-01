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
    
    
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.animalId == rhs.animalId
    }
}
