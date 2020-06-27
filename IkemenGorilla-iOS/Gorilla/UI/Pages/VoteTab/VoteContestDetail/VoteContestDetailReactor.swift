//
//  VoteContestDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class VoteContestDetailReactor: Reactor {
    enum Action {
        case loadContests
    }
    enum Mutation {
        case setEntryCellReactors([Entry])
    }
    
    struct State {
        let contest: Contest
        var entryCellReactors: [ContestDetailEntryCellReactor] = []
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadContests:
            return loadContests().map(Mutation.setEntryCellReactors)
        }
    }
    
    private func loadContests() -> Observable<[Entry]> {
        return .just(TestData.entries(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEntryCellReactors(let entries):
            state.entryCellReactors = entries.map { ContestDetailEntryCellReactor(entry: $0) }
        }
        return state
    }
}
