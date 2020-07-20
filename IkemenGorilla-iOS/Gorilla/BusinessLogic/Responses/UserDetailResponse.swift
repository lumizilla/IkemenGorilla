//
//  UserDetailResponse.swift
//  Gorilla
//
//  Created by admin on 2020/07/17.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct UserDetail: Codable {
    let id: String
    let name: String
    let iconUrl: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case iconUrl = "icon_url"
    }
}
