//
//  ProfileContestDetailPostCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileContestDetailPostCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let post: Post
        
        init(post: Post) {
            self.post = post
        }
    }
    
    let initialState: ProfileContestDetailPostCellReactor.State
    
    init(post: Post) {
        initialState = State(post: post)
    }
}

extension ProfileContestDetailPostCellReactor: Equatable {
    static func == (lhs: ProfileContestDetailPostCellReactor, rhs: ProfileContestDetailPostCellReactor) -> Bool {
        return lhs.currentState.post.id == rhs.currentState.post.id
    }
}
