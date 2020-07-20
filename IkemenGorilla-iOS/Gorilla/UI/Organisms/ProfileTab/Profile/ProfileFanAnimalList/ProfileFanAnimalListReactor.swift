//
//  ProfileFanAnimalListReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/11.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileFanAnimalListReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setFanAnimalListCellReactors([FanAnimal])
        case setIsLoading(Bool)
    }
    
    struct State {
        var animalListCellReactors: [ProfileFanAnimalListCellReactor] = []
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
            return Observable.concat(
                Observable.just(.setIsLoading(true)),
                loadFanAnimals().map(Mutation.setFanAnimalListCellReactors),
                Observable.just(.setIsLoading(false))
            )
        }
    }
    
    private func loadFanAnimals() -> Observable<[FanAnimal]> {
        logger.warning("no user id from UserDetailReactor")
        return provider.userService.getAnimals(userId: "5", page: 0).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setFanAnimalListCellReactors(let fanAnimals):
            state.animalListCellReactors = fanAnimals.map { ProfileFanAnimalListCellReactor(fanAnimal: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
