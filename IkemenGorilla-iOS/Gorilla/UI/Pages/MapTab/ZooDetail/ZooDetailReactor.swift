//
//  ZooDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ZooDetailReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let zoo: Zoo
        
        init(zoo: Zoo) {
            self.zoo = zoo
        }
    }
    
    let initialState: State
    
    init(zoo: Zoo) {
        initialState = State(zoo: zoo)
    }
}
