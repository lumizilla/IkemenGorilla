//
//  Formatter.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

let formatter = DateFormatter().then {
    $0.dateFormat = "MM-dd"
}
