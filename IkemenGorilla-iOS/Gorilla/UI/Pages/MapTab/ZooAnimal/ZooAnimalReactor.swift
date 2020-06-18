//
//  ZooAnimalReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ZooAnimalReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {
        var animals: [Animal] = []
    }
    
    let initialState: State

    init() {
        initialState = State()
    }
}
