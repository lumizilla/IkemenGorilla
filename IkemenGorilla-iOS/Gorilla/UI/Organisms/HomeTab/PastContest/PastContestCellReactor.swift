//
//  PastContestCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomePastContestCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contest: Contest
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: HomePastContestCellReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
}

extension HomePastContestCellReactor: Equatable {
    static func == (lhs: HomePastContestCellReactor, rhs: HomePastContestCellReactor) -> Bool {
        return lhs.currentState.contest.id == rhs.currentState.contest.id
    }
}
