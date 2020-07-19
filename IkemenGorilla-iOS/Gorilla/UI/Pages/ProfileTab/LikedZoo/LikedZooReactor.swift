//
//  LikedZooReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class LikedZooReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setZooCellReactors([RecommendedZoo])
        case setIsLoading(Bool)
    }
    
    struct State {
        var zooCellReactors: [LikedZooCellReactor] = []
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
        return provider.userService.getZoos(userId:"1", page: 0).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setZooCellReactors(let recommendedZoos):
            state.zooCellReactors = recommendedZoos.map { LikedZooCellReactor(recommendedZoo: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    func createZooDetailReactor(indexPath: IndexPath) -> ZooDetailReactor {
        let likedZoo = currentState.zooCellReactors[indexPath.row].currentState.recommendedZoo
        let zoo: Zoo = Zoo(id: likedZoo.id, name: likedZoo.name, address: "", latitude: 0, longitude: 0, imageUrl: likedZoo.imageUrl)
        return ZooDetailReactor(provider: provider, zoo: zoo)
    }
    
}
