//
//  AnimalDetailPastContestCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/26.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class AnimalDetailPastContestCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contest: Contest
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: AnimalDetailPastContestCellReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
}

extension AnimalDetailPastContestCellReactor: Equatable {
    static func == (lhs: AnimalDetailPastContestCellReactor, rhs: AnimalDetailPastContestCellReactor) -> Bool {
        return lhs.currentState.contest.id == rhs.currentState.contest.id
    }
}
