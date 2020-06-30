//
//  Contest.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Contest: Entity {
    let id: String
    let name: String
    let start: Date
    let end: Date
    let status: String
    let catchCopy: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, start, end, status
        case catchCopy = "catch_copy"
        case imageUrl = "image_url"
    }
    
    static func == (lhs: Contest, rhs: Contest) -> Bool {
        lhs.id == rhs.id
    }
}
