//
//  RecommendedZooCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class RecommendedZooCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let zoo: Zoo
        
        init(zoo: Zoo) {
            self.zoo = zoo
        }
    }
    
    let initialState: RecommendedZooCellReactor.State
    
    init(zoo: Zoo) {
        initialState = State(zoo: zoo)
    }
}

extension RecommendedZooCellReactor: Equatable {
    static func == (lhs: RecommendedZooCellReactor, rhs: RecommendedZooCellReactor) -> Bool {
        return lhs.currentState.zoo.id == rhs.currentState.zoo.id
    }
}
