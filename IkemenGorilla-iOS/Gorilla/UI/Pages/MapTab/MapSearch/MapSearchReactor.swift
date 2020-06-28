//
//  MapSearchReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class MapSearchReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let zoos: [Zoo]
        
        init(zoos: [Zoo]) {
            self.zoos = zoos
        }
    }
    
    let initialState: State
    
    init(zoos: [Zoo]) {
        initialState = State(zoos: zoos)
    }
}
