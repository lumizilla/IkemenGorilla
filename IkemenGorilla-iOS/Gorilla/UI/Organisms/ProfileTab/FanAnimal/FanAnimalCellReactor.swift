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
        var animal: Animal
        
        init(animal: Animal) {
            self.animal = animal
        }
    }
    
    let initialState: State
    
    init(animal: Animal) {
        initialState = State(animal: animal)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapFanButton:
            return .just(.setIsFan(!currentState.animal.isFan))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setIsFan(let isFan):
            state.animal.isFan = isFan
        }
        return state
    }
}

extension FanAnimalCellReactor: Equatable {
    static func == (lhs: FanAnimalCellReactor, rhs: FanAnimalCellReactor) -> Bool {
        return lhs.currentState.animal.id == rhs.currentState.animal.id
    }
}
