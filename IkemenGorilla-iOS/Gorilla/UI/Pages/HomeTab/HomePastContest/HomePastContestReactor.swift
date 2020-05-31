//
//  HomePastContestReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomePastContestReactor: Reactor {
    enum Action {
        case load
    }
    enum Mutation {
        case setContestCellReactors([Contest])
        case setIsLoading(Bool)
    }
    
    struct State {
        var contestCellReactors: [HomePastContestCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState = HomePastContestReactor.State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return Observable.concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setContestCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[Contest]> {
        .just(TestData.testContests(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setContestCellReactors(let contests):
            state.contestCellReactors = contests.map { HomePastContestCellReactor(contest: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
