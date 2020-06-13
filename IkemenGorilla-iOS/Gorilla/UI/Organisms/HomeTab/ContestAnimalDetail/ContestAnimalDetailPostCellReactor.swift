//
//  ContestAnimalDetailPostCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/12.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestAnimalDetailPostCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let post: Post
        
        init(post: Post) {
            self.post = post
        }
    }
    
    let initialState: ContestAnimalDetailPostCellReactor.State
    
    init(post: Post) {
        initialState = State(post: post)
    }
}

extension ContestAnimalDetailPostCellReactor: Equatable {
    static func == (lhs: ContestAnimalDetailPostCellReactor, rhs: ContestAnimalDetailPostCellReactor) -> Bool {
        return lhs.currentState.post.id == rhs.currentState.post.id
    }
}
