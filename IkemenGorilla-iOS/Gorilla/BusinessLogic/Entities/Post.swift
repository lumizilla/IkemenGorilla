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
    
    enum CodingKeys: String, CodingKey {
        case id
        case animalId = "animal_id"
        case animalName = "animal_name"
        case animalIconUrl = "animal_icon_url"
        case zooId = "zoo_id"
        case zooName = "zoo_name"
        case imageUrl = "image_url"
        case description
        case createdAt = "created_at"
    }
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
