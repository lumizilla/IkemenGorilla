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
        
        init(postCellReactors: [PostCellReactor]) {
            self.postCellReactors = postCellReactors
        }
    }
    
    let initialState: State
    
    init(postCellReactors: [PostCellReactor]) {
        initialState = State(postCellReactors: postCellReactors)
    }
}
