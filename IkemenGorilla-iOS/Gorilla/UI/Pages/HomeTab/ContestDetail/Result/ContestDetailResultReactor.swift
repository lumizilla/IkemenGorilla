//
//  ContestDetailResultReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailResultReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setAwardCellReactors([Award])
        case setIsLoading(Bool)
    }
    
    struct State {
        let contest: Contest
        var awardCellReactors: [ContestDetailResultAwardCellReactor] = []
        var isLoading: Bool = false
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ContestDetailResultReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setAwardCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[Award]> {
        return .just(TestData.awards(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAwardCellReactors(let awards):
            state.awardCellReactors = awards.map { ContestDetailResultAwardCellReactor(award: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
