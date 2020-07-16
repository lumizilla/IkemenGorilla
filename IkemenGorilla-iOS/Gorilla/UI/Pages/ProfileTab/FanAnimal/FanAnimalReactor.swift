//
//  FanAnimalReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/11.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class FanAnimalReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setAnimalCellReactors([Animal])
        case setIsLoading(Bool)
    }
    
    struct State {
        var animalCellReactors: [FanAnimalCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState: State
    private let provider: ServiceProviderType

    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return Observable.concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setAnimalCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[Animal]> {
        .just(TestData.animals(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAnimalCellReactors(let animals):
            state.animalCellReactors += animals.map { FanAnimalCellReactor(animal: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    func createFanAnimalDetailReactor(indexPath: IndexPath) -> FanAnimalDetailReactor {
        return FanAnimalDetailReactor(provider: provider, animal: currentState.animalCellReactors[indexPath.row].currentState.animal)
    }
    
}
