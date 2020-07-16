//
//  ExplorePostDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ExplorePostDetailReactor: Reactor {
    enum Action {
        case didScrollToItem
    }
    enum Mutation {
        case setDidScrollToItem
    }
    
    struct State {
        let startAt: Int
        var didScrollToItem: Bool = false
        var postCellReactors: [PostCellReactor]
        
        init(startAt: Int, posts: [Post]) {
            self.startAt = startAt
            self.postCellReactors = posts.map { PostCellReactor(post: $0) }
        }
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, startAt: Int, posts: [Post]) {
        self.provider = provider
        initialState = State(startAt: startAt, posts: posts)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didScrollToItem:
            return .just(.setDidScrollToItem)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setDidScrollToItem:
            state.didScrollToItem = true
        }
        return state
    }
    
    func createAnimalDetailReactor(zooAnimal: ZooAnimal) -> AnimalDetailReactor {
        return AnimalDetailReactor(provider: provider, zooAnimal: zooAnimal)
    }
}
