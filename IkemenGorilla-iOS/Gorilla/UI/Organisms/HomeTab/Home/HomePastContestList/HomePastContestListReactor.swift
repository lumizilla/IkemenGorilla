//
//  HomePastContestListReactor.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomePastContestListReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setContestListCellReactors([Contest])
        case setIsLoading(Bool)
    }
    
    struct State {
        var contestListCellReactors: [HomePastContestListCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState = HomePastContestListReactor.State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return Observable.concat(
                Observable.just(.setIsLoading(true)),
                loadPastContests().map(Mutation.setContestListCellReactors),
                Observable.just(.setIsLoading(false))
            )
        }
    }
    
    private func loadPastContests() -> Observable<[Contest]> {
        .just(TestData.testContests(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setContestListCellReactors(let contests):
            state.contestListCellReactors = contests.map { HomePastContestListCellReactor(contest: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
