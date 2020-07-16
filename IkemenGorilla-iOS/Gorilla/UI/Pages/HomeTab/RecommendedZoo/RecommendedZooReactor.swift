//
//  RecommendedZooReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class RecommendedZooReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setZooCellReactors([RecommendedZoo])
        case setIsLoading(Bool)
    }
    
    struct State {
        var zooCellReactors: [RecommendedZooCellReactor] = []
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
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setZooCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[RecommendedZoo]> {
        return provider.zooService.getRecommendedZoos().asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setZooCellReactors(let recommendedZoos):
            state.zooCellReactors = recommendedZoos.map { RecommendedZooCellReactor(recommendedZoo: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    func createZooDetailReactor(indexPath: IndexPath) -> ZooDetailReactor {
        let recommendedZoo = currentState.zooCellReactors[indexPath.row].currentState.recommendedZoo
        let zoo: Zoo = Zoo(id: recommendedZoo.id, name: recommendedZoo.name, address: "", latitude: 0, longitude: 0, imageUrl: recommendedZoo.imageUrl)
        return ZooDetailReactor(provider: provider, zoo: zoo)
    }
}
