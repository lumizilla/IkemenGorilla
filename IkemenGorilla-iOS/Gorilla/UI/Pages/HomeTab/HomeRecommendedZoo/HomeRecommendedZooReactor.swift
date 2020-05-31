//
//  HomeRecommendedZooReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeRecommendedZooReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setZooCellReactors([Zoo])
        case setIsLoading(Bool)
    }
    
    struct State {
        var zooCellReactors: [HomeRecommendedZooCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState = HomeRecommendedZooReactor.State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setZooCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[Zoo]> {
        .just(TestData.testZoos(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setZooCellReactors(let zoos):
            state.zooCellReactors = zoos.map { HomeRecommendedZooCellReactor(zoo: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
