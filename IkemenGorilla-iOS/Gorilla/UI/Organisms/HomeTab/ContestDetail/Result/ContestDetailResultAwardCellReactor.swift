//
//  ContestDetailResultAwardCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailResultAwardCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let award: Award
        
        init(award: Award) {
            self.award = award
        }
    }
    
    let initialState: ContestDetailResultAwardCellReactor.State
    
    init(award: Award) {
        initialState = State(award: award)
    }
}

extension ContestDetailResultAwardCellReactor: Equatable {
    static func == (lhs: ContestDetailResultAwardCellReactor, rhs: ContestDetailResultAwardCellReactor) -> Bool {
        return lhs.currentState.award.animalId == rhs.currentState.award.animalId
    }
}
