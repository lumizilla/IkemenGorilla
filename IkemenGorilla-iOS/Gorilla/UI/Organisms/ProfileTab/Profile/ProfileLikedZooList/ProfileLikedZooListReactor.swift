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
        case setLikedZooListCellReactors([RecommendedZoo])
        case setIsLoading(Bool)
    }
    
    struct State {
        var likedZooListCellReactors: [ProfileLikedZooListCellReactor] = []
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
            return Observable.concat(
                Observable.just(.setIsLoading(true)),
                loadLikedZoos().map(Mutation.setLikedZooListCellReactors),
                Observable.just(.setIsLoading(false))
            )
        }
    }
    
    private func loadLikedZoos() -> Observable<[RecommendedZoo]> {
        return provider.userService.getZoos(userId: "1", page: 0).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setLikedZooListCellReactors(let recommendedZoos):
            state.likedZooListCellReactors = recommendedZoos.map { ProfileLikedZooListCellReactor(recommendedZoo: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    func createZooDetailReactor(indexPath: IndexPath) -> ZooDetailReactor {
        let recommendedZoo = currentState.likedZooListCellReactors[indexPath.row].currentState.recommendedZoo
        let zoo: Zoo = Zoo(id: recommendedZoo.id, name: recommendedZoo.name, address: "", latitude: 0, longitude: 0, imageUrl: recommendedZoo.imageUrl)
        return ZooDetailReactor(provider: provider, zoo: zoo)
    }
}
