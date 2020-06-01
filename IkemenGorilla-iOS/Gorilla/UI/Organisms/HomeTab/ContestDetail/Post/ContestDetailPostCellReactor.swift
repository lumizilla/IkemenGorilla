//
//  ContestDetailPostCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailPostCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let post: Post
        
        init(post: Post) {
            self.post = post
        }
    }
    
    let initialState: ContestDetailPostCellReactor.State
    
    init(post: Post) {
        initialState = State(post: post)
    }
}
