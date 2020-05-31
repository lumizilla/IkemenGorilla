//
//  PastContestCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class PastContestCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contest: Contest
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: PastContestCellReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
}

extension PastContestCellReactor: Equatable {
    static func == (lhs: PastContestCellReactor, rhs: PastContestCellReactor) -> Bool {
        return lhs.currentState.contest.id == rhs.currentState.contest.id
    }
}
