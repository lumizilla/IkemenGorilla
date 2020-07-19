//
//  ProfileContestDetailEntryCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileContestDetailEntryCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let entry: Entry
        
        init(entry: Entry) {
            self.entry = entry
        }
    }
    
    let initialState: ProfileContestDetailEntryCellReactor.State
    
    init(entry: Entry) {
        initialState = State(entry: entry)
    }
}

extension ProfileContestDetailEntryCellReactor: Equatable {
    static func == (lhs: ProfileContestDetailEntryCellReactor, rhs: ProfileContestDetailEntryCellReactor) -> Bool {
        return lhs.currentState.entry.animalId == rhs.currentState.entry.animalId
    }
}
