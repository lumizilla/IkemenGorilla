//
//  HomeRecommendedZooListReactor.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeRecommendedZooListReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setRecommendedZooListCellReactors([Zoo])
        case setIsLoading(Bool)
    }
    
    struct State {
        var recommendedZooListCellReactors: [HomeRecommendedZooListCellReactor] = []
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
                loadRecommendedZoos().map(Mutation.setRecommendedZooListCellReactors),
                Observable.just(.setIsLoading(false))
            )
        }
    }
    
    private func loadRecommendedZoos() -> Observable<[Zoo]> {
        .just(TestData.zoos(count: 4))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setRecommendedZooListCellReactors(let zoos):
            state.recommendedZooListCellReactors = zoos.map { HomeRecommendedZooListCellReactor(zoo: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
