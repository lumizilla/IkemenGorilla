//
//  ZooAnimalCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ZooAnimalCellReactor: Reactor {
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

extension ZooAnimalCellReactor: Equatable {
    static func == (lhs: ZooAnimalCellReactor, rhs: ZooAnimalCellReactor) -> Bool {
        return lhs.currentState.animal.id == rhs.currentState.animal.id
    }
}
