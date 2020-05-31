//
//  HomePastContestReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomePastContestReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        var contestCellReactors: [HomePastContestCellReactor] = []
        var isLoading: Bool = false
    }
    
    let initialState = HomePastContestReactor.State()
}
