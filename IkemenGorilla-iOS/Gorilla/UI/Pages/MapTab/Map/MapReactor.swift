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
        case tapAnnotations(annotations: [PointZooAnnotation])
        case closeList
    }
    enum Mutation {
        case setZoos([Zoo])
        case setAnnotations(annotations: [PointZooAnnotation])
    }
    struct State {
        var zoos: [Zoo] = []
        var selectedAnnotations: [PointZooAnnotation] = []
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadZoos:
            return loadZoos().map(Mutation.setZoos)
        case .tapAnnotations(let annotations):
            return .just(.setAnnotations(annotations: annotations))
        case .closeList:
            return .just(.setAnnotations(annotations: []))
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
        case .setAnnotations(let annotations):
            state.selectedAnnotations = annotations
        }
        return state
    }
}
