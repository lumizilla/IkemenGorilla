//
//  Post.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Post: Entity {
    let id: String
    let animalId: String
    let animalName: String
    let animalIconUrl: String
    let zooId: String
    let zooName: String
    let imageUrl: String
    let description: String
    let createdAt: Date
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
