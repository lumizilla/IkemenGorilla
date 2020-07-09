//
//  ExploreReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ExploreReactor: Reactor {
    enum Action {
        case loadPosts
    }
    
    enum Mutation {
        case setPosts([Post])
    }
    
    struct State {
        var posts: [Post] = []
    }
    
    var initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadPosts:
            return loadPosts().map(Mutation.setPosts)
        }
    }
    
    private func loadPosts() -> Observable<[Post]> {
        return .just(TestData.posts(count: 12))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setPosts(let posts):
            state.posts = posts
        }
        return state
    }
    
    func createExplorePostDetailReactor(indexPath: IndexPath) -> ExplorePostDetailReactor {
        return ExplorePostDetailReactor(startAt: indexPath.row, posts: currentState.posts)
    }
}
