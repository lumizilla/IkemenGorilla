//
//  FanAnimalCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/11.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class FanAnimalCellReactor: Reactor {
    enum Action {
        case tapFanButton
    }
    
    enum Mutation {
        case setIsFan(Bool)
    }
    
    struct State {
        var fanAnimal: FanAnimal
        
        init(fanAnimal: FanAnimal) {
            self.fanAnimal = fanAnimal
        }
    }
    
    let initialState: State
    
    init(fanAnimal: FanAnimal) {
        initialState = State(fanAnimal: fanAnimal)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapFanButton:
            return .just(.setIsFan(!currentState.fanAnimal.isFan))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setIsFan(let isFan):
            state.fanAnimal.isFan = isFan
        }
        return state
    }
}

extension FanAnimalCellReactor: Equatable {
    static func == (lhs: FanAnimalCellReactor, rhs: FanAnimalCellReactor) -> Bool {
        return lhs.currentState.fanAnimal.id == rhs.currentState.fanAnimal.id
    }
}
