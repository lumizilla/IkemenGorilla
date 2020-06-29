//
//  ContestDetailResponse.swift
//  Gorilla
//
//  Created by admin on 2020/06/29.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct ContestDetail: Codable {
    let id: String
    let name: String
    let start: Date
    let end: Date
    let status: String
    let catchCopy: String
    var description: String? = ""
    let imageUrl: String
    let numberOfEntries: Int
    let numberOfVotedPeople: Int
    let numberOfVotes: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, start, end, status, description
        case catchCopy = "catch_copy"
        case imageUrl = "image_url"
        case numberOfEntries = "number_of_entries"
        case numberOfVotedPeople = "number_of_voted_people"
        case numberOfVotes = "number_of_votes"
    }
}
