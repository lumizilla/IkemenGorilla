//
//  MapSearchReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class MapSearchReactor: Reactor {
    enum Action {
        case updateKeyword(String)
    }
    enum Mutation {
        case setSearchResult([MapSearchResultCellReactor])
    }
    
    struct State {
        let allCellReactors: [MapSearchResultCellReactor]
        var searchResultCellReactors: [MapSearchResultCellReactor] = []
        
        init(zoos: [Zoo]) {
            self.allCellReactors = zoos.map { MapSearchResultCellReactor(zoo: $0) }
        }
    }
    
    let initialState: State
    
    init(zoos: [Zoo]) {
        initialState = State(zoos: zoos)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateKeyword(let keyword):
            if keyword.isEmpty {
                return .just(.setSearchResult(currentState.allCellReactors))
            }
            let results = currentState.allCellReactors.filter { $0.currentState.zoo.name.contains(keyword) }
            return .just(.setSearchResult(results))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setSearchResult(let results):
            state.searchResultCellReactors = results
        }
        return state
    }
}
