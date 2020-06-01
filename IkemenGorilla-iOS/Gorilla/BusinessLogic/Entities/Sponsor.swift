//
//  Sponsor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Sponsor: Entity {
    let id: String
    let name: String
    let imageUrl: String
    let websiteUrl: String
    
    static func == (lhs: Sponsor, rhs: Sponsor) -> Bool {
        lhs.id == rhs.id
    }
}
