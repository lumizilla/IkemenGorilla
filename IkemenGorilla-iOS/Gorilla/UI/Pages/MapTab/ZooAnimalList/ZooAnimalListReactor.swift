//
//  ZooAnimalListReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ZooAnimalReactor: Reactor {
    enum Action {
        case loadAnimals
    }
    enum Mutation {
        case setAnimalCellReactors([Animal])
    }
    struct State {
        let zoo: Zoo
        var animalCellReactors: [ZooAnimalCellReactor] = []
        
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
            state.animalCellReactors = animals.map { ZooAnimalCellReactor(animal: $0) }
        }
        return state
    }
    
    func createAnimalDetailReactor(indexPath: IndexPath) -> AnimalDetailReactor {
        return AnimalDetailReactor(animal: currentState.animalCellReactors[indexPath.row].currentState.animal)
    }
}
