//
//  ProfileCurrentContestListCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileCurrentContestListCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contest: Contest
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ProfileCurrentContestListCellReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
}

