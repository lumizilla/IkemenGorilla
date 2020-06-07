//
//  ProfileInfoReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/06.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileInfoReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setProfileInfoCellReactors([Profile])
        case setIsLoading(Bool)
    }
    
    struct State {
        var profileInfoCellReactors: [ProfileInfoCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState = ProfileInfoReactor.State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setProfileInfoCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[Profile]> {
        .just(TestData.profiles(count: 1))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setProfileInfoCellReactors(let profiles):
            state.profileInfoCellReactors = profiles.map { ProfileInfoCellReactor(profile: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
