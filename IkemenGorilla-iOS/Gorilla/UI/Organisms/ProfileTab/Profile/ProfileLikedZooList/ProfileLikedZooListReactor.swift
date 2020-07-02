//
//  ProfileLikedZooListReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileLikedZooListReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setLikedZooListCellReactors([Zoo])
        case setIsLoading(Bool)
    }
    
    struct State {
        var likedZooListCellReactors: [ProfileLikedZooListCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState = ProfileLikedZooListReactor.State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return Observable.concat(
                Observable.just(.setIsLoading(true)),
                loadLikedZoos().map(Mutation.setLikedZooListCellReactors),
                Observable.just(.setIsLoading(false))
            )
        }
    }
    
    private func loadLikedZoos() -> Observable<[Zoo]> {
        .just(TestData.zoos(count: 4))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setLikedZooListCellReactors(let zoos):
            state.likedZooListCellReactors = zoos.map { ProfileLikedZooListCellReactor(zoo: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
