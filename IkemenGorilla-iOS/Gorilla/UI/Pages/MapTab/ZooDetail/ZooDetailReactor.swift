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
    enum Action {
        case loadAnimals
    }
    enum Mutation {
        case setAnimalCellReactors([Animal])
    }
    
    struct State {
        let zoo: Zoo
        var animalCellReactors: [ZooDetailAnimalCellReactor] = []
        
        init(zoo: Zoo) {
            self.zoo = zoo
        }
    }
    
    let initialState: State
    
    init(zoo: Zoo) {
        initialState = State(zoo: zoo)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadAnimals:
            return loadAnimals().map(Mutation.setAnimalCellReactors)
        }
    }
    
    private func loadAnimals() -> Observable<[Animal]> {
        return .just(TestData.animals(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAnimalCellReactors(let animals):
            state.animalCellReactors = animals.map { ZooDetailAnimalCellReactor(animal: $0) }
        }
        return state
    }
}
