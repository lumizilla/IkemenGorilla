//
//  HomeRecommendedZooListReactor.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeRecommendedZooListReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setRecommendedZooListCellReactors([RecommendedZoo])
        case setIsLoading(Bool)
    }
    
    struct State {
        var recommendedZooListCellReactors: [HomeRecommendedZooListCellReactor] = []
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
                loadRecommendedZoos().map(Mutation.setRecommendedZooListCellReactors),
                Observable.just(.setIsLoading(false))
            )
        }
    }
    
    private func loadRecommendedZoos() -> Observable<[RecommendedZoo]> {
        return provider.zooService.getRecommendedZoos().asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setRecommendedZooListCellReactors(let recommendedZoos):
            state.recommendedZooListCellReactors = recommendedZoos.map { HomeRecommendedZooListCellReactor(recommendedZoo: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    func createZooDetailReactor(indexPath: IndexPath) -> ZooDetailReactor {
        let recommendedZoo = currentState.recommendedZooListCellReactors[indexPath.row].currentState.recommendedZoo
        let zoo: Zoo = Zoo(id: recommendedZoo.id, name: recommendedZoo.name, address: "", latitude: 0, longitude: 0, imageUrl: recommendedZoo.imageUrl)
        return ZooDetailReactor(provider: provider, zoo: zoo)
    }
}
