//
//  Store.swift
//  Gorilla
//
//  Created by admin on 2020/07/15.
//  Copyright © 2020 admin. All rights reserved.
//

import SwiftyUserDefaults
import Then

protocol StoreType {
    var userID: String? { get set }
}

final class Store: StoreType {
    var userID: String? {
        get { Defaults[\.userID] }
        set { Defaults[\.userID] = newValue }
    }
}
