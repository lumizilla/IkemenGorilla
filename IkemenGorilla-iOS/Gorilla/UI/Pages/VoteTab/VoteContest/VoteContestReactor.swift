//
//  VoteContestReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class VoteContestReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        var contestCellReactors: [VoteContestCellReactor] = []
    }
    
    let initialState: State = State()
    
}
