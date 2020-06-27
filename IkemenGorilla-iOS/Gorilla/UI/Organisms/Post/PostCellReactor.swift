//
//  PostCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/26.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class PostCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let post: Post
        
        init(post: Post) {
            self.post = post
        }
    }
    
    let initialState: PostCellReactor.State
    
    init(post: Post) {
        initialState = State(post: post)
    }
}

extension PostCellReactor: Equatable {
    static func == (lhs: PostCellReactor, rhs: PostCellReactor) -> Bool {
        return lhs.currentState.post.id == rhs.currentState.post.id
    }
}
