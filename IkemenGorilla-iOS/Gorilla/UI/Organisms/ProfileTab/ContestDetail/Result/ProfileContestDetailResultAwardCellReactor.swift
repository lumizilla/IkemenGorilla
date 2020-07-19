//
//  ProfileContestDetailResultAwardCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileContestDetailResultAwardCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let award: Award
        
        init(award: Award) {
            self.award = award
        }
    }
    
    let initialState: ProfileContestDetailResultAwardCellReactor.State
    
    init(award: Award) {
        initialState = State(award: award)
    }
}

extension ProfileContestDetailResultAwardCellReactor: Equatable {
    static func == (lhs: ProfileContestDetailResultAwardCellReactor, rhs: ProfileContestDetailResultAwardCellReactor) -> Bool {
        return lhs.currentState.award.animalId == rhs.currentState.award.animalId
    }
}
