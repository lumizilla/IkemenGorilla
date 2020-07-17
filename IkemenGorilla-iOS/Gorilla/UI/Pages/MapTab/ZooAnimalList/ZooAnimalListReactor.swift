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
        case refresh
        case load
    }
    enum Mutation {
        case setAnimalCellReactors([ZooAnimal])
        case addAnimalCellReactors([ZooAnimal])
        case setPage(Int)
        case setApiStatus(APIStatus)
    }
    struct State {
        let zoo: Zoo
        var animalCellReactors: [ZooAnimalCellReactor]
        var page: Int = 0
        var isReachedBottom: Bool = false
        var apiStatus: APIStatus = .pending
        
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
        case .refresh:
            guard currentState.apiStatus == .pending else { return .empty() }
            return .concat(
                .just(.setApiStatus(.refreshing)),
                load(page: 0).map(Mutation.setAnimalCellReactors),
                .just(.setPage(0)),
                .just(.setApiStatus(.pending))
            )
        case .load:
            guard currentState.apiStatus == .pending && !currentState.isReachedBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                load(page: currentState.page+1).map(Mutation.addAnimalCellReactors),
                .just(.setPage(currentState.page+1)),
                .just(.setApiStatus(.pending))
            )
        }
    }
    
    private func load(page: Int) -> Observable<[ZooAnimal]> {
        return provider.zooService.getAnimals(zooId: currentState.zoo.id, page: page, userId: "1").asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAnimalCellReactors(let zooAnimals):
            state.animalCellReactors = zooAnimals.map { ZooAnimalCellReactor(zooAnimal: $0) }
            state.isReachedBottom = zooAnimals.count < 8
        case .addAnimalCellReactors(let zooAnimals):
            state.animalCellReactors += zooAnimals.map { ZooAnimalCellReactor(zooAnimal: $0) }
            state.isReachedBottom = zooAnimals.count < 8
        case .setPage(let page):
            state.page = page
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }
    
    func createAnimalDetailReactor(indexPath: IndexPath) -> AnimalDetailReactor {
        return AnimalDetailReactor(provider: provider, zooAnimal: currentState.animalCellReactors[indexPath.row].currentState.zooAnimal)
    }
}
