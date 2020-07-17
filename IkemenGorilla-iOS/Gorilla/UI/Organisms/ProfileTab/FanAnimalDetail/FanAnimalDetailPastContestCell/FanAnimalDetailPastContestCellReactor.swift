//
//  FanAnimalDetailPastContestCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class FanAnimalDetailPastContestCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contest: Contest
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: FanAnimalDetailPastContestCellReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
}

extension FanAnimalDetailPastContestCellReactor: Equatable {
    static func == (lhs: FanAnimalDetailPastContestCellReactor, rhs: FanAnimalDetailPastContestCellReactor) -> Bool {
        return lhs.currentState.contest.id == rhs.currentState.contest.id
    }
}
