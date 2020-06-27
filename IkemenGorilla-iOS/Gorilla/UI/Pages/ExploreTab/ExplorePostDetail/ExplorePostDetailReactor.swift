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
    enum Action {}
    enum Mutation {}
    
    struct State {
        var postCellReactors: [PostCellReactor]
        
        init(posts: [Post]) {
            self.postCellReactors = posts.map { PostCellReactor(post: $0) }
        }
    }
    
    let initialState: State
    
    init(posts: [Post]) {
        initialState = State(posts: posts)
    }
}
