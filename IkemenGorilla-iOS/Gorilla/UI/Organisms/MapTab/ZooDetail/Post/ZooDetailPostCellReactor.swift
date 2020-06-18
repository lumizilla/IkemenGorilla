//
//  ZooDetailPostCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ZooDetailPostCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let post: Post
        
        init(post: Post) {
            self.post = post
        }
    }
    
    let initialState: ZooDetailPostCellReactor.State
    
    init(post: Post) {
        initialState = State(post: post)
    }
}

extension ZooDetailPostCellReactor: Equatable {
    static func == (lhs: ZooDetailPostCellReactor, rhs: ZooDetailPostCellReactor) -> Bool {
        return lhs.currentState.post.id == rhs.currentState.post.id
    }
}
