//
//  HomeCurrentContestListCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeCurrentContestListCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contest: Contest
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: HomeCurrentContestListCellReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
}
