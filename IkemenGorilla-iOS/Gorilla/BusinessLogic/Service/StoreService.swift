//
//  StoreService.swift
//  Gorilla
//
//  Created by admin on 2020/07/15.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol StoreServiceType {
    var store: StoreType { get set }
}

class StoreService: BaseService, StoreServiceType {
    var store: StoreType = Store()
}
