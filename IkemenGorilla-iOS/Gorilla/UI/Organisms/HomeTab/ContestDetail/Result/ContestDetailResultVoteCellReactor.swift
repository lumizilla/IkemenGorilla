//
//  ContestDetailResultVoteCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailResultVoteCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contestResult: ContestResult
        
        init(contestResult: ContestResult) {
            self.contestResult = contestResult
        }
    }
    
    let initialState: ContestDetailResultVoteCellReactor.State
    
    init(contestResult: ContestResult) {
        initialState = State(contestResult: contestResult)
    }
}
