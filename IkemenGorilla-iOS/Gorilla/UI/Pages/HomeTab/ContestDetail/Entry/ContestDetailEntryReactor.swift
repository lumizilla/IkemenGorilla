//
//  ContestDetailEntryReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailEntryReactor: Reactor {
    enum Action {
        case load
    }
    enum Mutation {
        case setEntryCellReactors([Entry])
        case setIsLoading(Bool)
    }
    
    struct State {
        let contest: Contest
        var entryCellReactors: [ContestDetailEntryCellReactor] = []
        var isLoading: Bool = false
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ContestDetailEntryReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setEntryCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[Entry]> {
        return .just(TestData.entries(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEntryCellReactors(let entries):
            state.entryCellReactors = entries.map { ContestDetailEntryCellReactor(entry: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
