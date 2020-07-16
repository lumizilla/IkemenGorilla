//
//  GorillaDecoder.swift
//  Gorilla
//
//  Created by admin on 2020/06/29.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

final class GorillaDecoder: JSONDecoder {
    static let `default` = GorillaDecoder()
    
    override init() {
        super.init()
        dateDecodingStrategy = .formatted(DateFormatter().then {
            $0.locale = Locale(identifier: "en_US_POSIX")
            $0.dateFormat = "dd-MM-yyyy"
        })
    }
}
