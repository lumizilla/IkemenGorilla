//
//  PostPhotoCollectionReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

class PostPhotoCollectionReactor: Reactor {
    enum Action {
        case setPosts([Post])
    }
    enum Mutation {
        case setPostCellReactors([Post])
    }
    
    struct State {
        var postCellReactors: [PostCellReactor] = []
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setPosts(let posts):
            return .just(.setPostCellReactors(posts))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setPostCellReactors(let posts):
            state.postCellReactors = posts.map { PostCellReactor(post: $0) }
        }
        return state
    }
}
