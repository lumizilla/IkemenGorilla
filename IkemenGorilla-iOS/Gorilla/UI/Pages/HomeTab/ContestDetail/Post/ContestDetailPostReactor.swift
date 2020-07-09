//
//  ContestDetailPostReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailPostReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setPostCellReactors([Post])
        case setIsLoading(Bool)
    }
    
    struct State {
        let contest: Contest
        var postCellReactors: [ContestDetailPostCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState: ContestDetailPostReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setPostCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[Post]> {
        return .just(TestData.posts(count: 12))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setPostCellReactors(let posts):
            state.postCellReactors = posts.map { ContestDetailPostCellReactor(post: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
