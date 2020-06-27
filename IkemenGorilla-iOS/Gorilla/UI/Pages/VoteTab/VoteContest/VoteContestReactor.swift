//
//  VoteContestReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class VoteContestReactor: Reactor {
    enum Action {
        case loadContest
    }
    enum Mutation {
        case setContestCellReactors([Contest])
    }
    
    struct State {
        var contestCellReactors: [VoteContestCellReactor] = []
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadContest:
            return loadContest().map(Mutation.setContestCellReactors)
        }
    }
    
    private func loadContest() -> Observable<[Contest]> {
        return .just(TestData.contests(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setContestCellReactors(let contests):
            state.contestCellReactors = contests.map { VoteContestCellReactor(contest: $0) }
        }
        return state
    }
}
