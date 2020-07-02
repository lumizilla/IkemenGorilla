//
//  ZooAnimalListReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ZooAnimalListReactor: Reactor {
    enum Action {
        case loadAnimals
    }
    enum Mutation {
        case setAnimalCellReactors([ZooAnimal])
    }
    struct State {
        let zoo: Zoo
        var animalCellReactors: [ZooAnimalCellReactor]
        
        init(zoo: Zoo, zooAnimals: [ZooAnimal]) {
            self.zoo = zoo
            self.animalCellReactors = zooAnimals.map { ZooAnimalCellReactor(zooAnimal: $0) }
        }
    }
    
    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType, zoo: Zoo, zooAnimals: [ZooAnimal]) {
        self.provider = provider
        initialState = State(zoo: zoo, zooAnimals: zooAnimals)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadAnimals:
            return loadAnimals().map(Mutation.setAnimalCellReactors)
        }
    }
    
    private func loadAnimals() -> Observable<[ZooAnimal]> {
        return .just(TestData.zooAnimals(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAnimalCellReactors(let zooAnimals):
            state.animalCellReactors += zooAnimals.map { ZooAnimalCellReactor(zooAnimal: $0) }
        }
        return state
    }
    
    func createAnimalDetailReactor(indexPath: IndexPath) -> AnimalDetailReactor {
        return AnimalDetailReactor(provider: provider, zooAnimal: currentState.animalCellReactors[indexPath.row].currentState.zooAnimal)
    }
}
