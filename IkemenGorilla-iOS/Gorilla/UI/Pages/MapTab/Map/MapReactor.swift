//
//  MapReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/16.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class MapReactor: Reactor {
    enum Action {
        case loadZoos
    }
    enum Mutation {
        case setZoos([Zoo])
    }
    struct State {
        var zoos: [Zoo] = []
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadZoos:
            return loadZoos().map(Mutation.setZoos)
        }
    }
    
    private func loadZoos() -> Observable<[Zoo]> {
        return .just(TestData.zoos(count: 20))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setZoos(let zoos):
            state.zoos = zoos
        }
        return state
    }
}
