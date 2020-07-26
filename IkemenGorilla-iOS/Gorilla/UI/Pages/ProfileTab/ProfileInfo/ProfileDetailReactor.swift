//
//  ProfileDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/17.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileDetailReactor: Reactor {
    enum Action {
        case loadUserDetail
    }
    
    enum Mutation {
        case setUserDetail(UserDetail)
        case setIsLoading(Bool)
    }
    
    struct State {
        var userDetail: UserDetail?
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
        case .loadUserDetail:
            guard !currentState.isLoading else { return .empty() }
            return Observable.concat(
                Observable.just(.setIsLoading(true)),
                loadUserDetail().map(Mutation.setUserDetail),
                Observable.just(.setIsLoading(false))
            )
        }
    }
    
    private func loadUserDetail() -> Observable<UserDetail> {
        logger.warning("no user id from UserDetailReactor")
        let userId = Int.random(in: 1 ..< 7)
        return provider.userService.getUser(userId: String(userId)).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setUserDetail(let userDetail):
            state.userDetail = userDetail
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}

