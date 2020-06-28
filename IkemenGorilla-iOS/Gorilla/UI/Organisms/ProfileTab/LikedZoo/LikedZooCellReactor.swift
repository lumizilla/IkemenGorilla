//
//  LikedZooCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class LikedZooCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let zoo: Zoo
        
        init(zoo: Zoo) {
            self.zoo = zoo
        }
    }
    
    let initialState: LikedZooCellReactor.State
    
    init(zoo: Zoo) {
        initialState = State(zoo: zoo)
    }
}

extension LikedZooCellReactor: Equatable {
    static func == (lhs: LikedZooCellReactor, rhs: LikedZooCellReactor) -> Bool {
        return lhs.currentState.zoo.id == rhs.currentState.zoo.id
    }
}
