//
//  MapReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/16.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift
import MapKit

final class MapReactor: Reactor {
    enum Action {
        case loadZoos
        case tapCluster(MKClusterAnnotation)
        case closeList
    }
    enum Mutation {
        case setZoos([Zoo])
        case setAnnotations(annotations: [PointZooAnnotation])
        case setCluster(MKClusterAnnotation?)
    }
    struct State {
        var zoos: [Zoo] = []
        var selectedAnnotations: [PointZooAnnotation] = []
        var clusterAnnotation: MKClusterAnnotation?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadZoos:
            return loadZoos().map(Mutation.setZoos)
        case .tapCluster(let cluster):
            var observables: [Observable<Mutation>] = []
            if let annotations = cluster.memberAnnotations as? [PointZooAnnotation] {
                observables.append(.just(.setAnnotations(annotations: annotations)))
            }
            observables.append(.just(.setCluster(cluster)))
            return .merge(observables)
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
        case .setCluster(let cluster):
            state.clusterAnnotation = cluster
        }
        return state
    }
    
    func createZooDetailReactor(zoo: Zoo) -> ZooDetailReactor {
        return ZooDetailReactor(zoo: zoo)
    }
}
