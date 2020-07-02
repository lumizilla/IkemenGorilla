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
        var zooAnimal: ZooAnimal
        
        init(zooAnimal: ZooAnimal) {
            self.zooAnimal = zooAnimal
        }
    }
    
    let initialState: State
    
    init(zooAnimal: ZooAnimal) {
        initialState = State(zooAnimal: zooAnimal)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapFanButton:
            return .just(.setIsFan(!currentState.zooAnimal.isFan))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setIsFan(let isFan):
            state.zooAnimal.isFan = isFan
        }
        return state
    }
}

extension ZooAnimalCellReactor: Equatable {
    static func == (lhs: ZooAnimalCellReactor, rhs: ZooAnimalCellReactor) -> Bool {
        return lhs.currentState.zooAnimal.id == rhs.currentState.zooAnimal.id
    }
}
