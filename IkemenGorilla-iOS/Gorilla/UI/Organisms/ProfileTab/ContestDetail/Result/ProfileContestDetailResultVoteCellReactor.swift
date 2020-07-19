//
//  ProfileContestDetailResultVoteCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileContestDetailResultVoteCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contestResult: ContestResult
        
        init(contestResult: ContestResult) {
            self.contestResult = contestResult
        }
    }
    
    let initialState: ProfileContestDetailResultVoteCellReactor.State
    
    init(contestResult: ContestResult) {
        initialState = State(contestResult: contestResult)
    }
}

extension ProfileContestDetailResultVoteCellReactor: Equatable {
    static func == (lhs: ProfileContestDetailResultVoteCellReactor, rhs: ProfileContestDetailResultVoteCellReactor) -> Bool {
        return lhs.currentState.contestResult.animalId == rhs.currentState.contestResult.animalId
    }
}
