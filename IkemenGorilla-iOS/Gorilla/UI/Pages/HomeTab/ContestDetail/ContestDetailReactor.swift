//
//  ContestDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contest: Contest
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ContestDetailReactor.State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, contest: Contest) {
        self.provider = provider
        initialState = State(contest: contest)
    }
    
    func createContestDetailInfoReactor() -> ContestDetailInfoReactor {
        return ContestDetailInfoReactor(provider: provider, contest: currentState.contest)
    }
    
    func createContestDetailEntryReactor() -> ContestDetailEntryReactor {
        return ContestDetailEntryReactor(provider: provider, contest: currentState.contest)
    }
    
    func createContestDetailPostReactor() -> ContestDetailPostReactor {
        return ContestDetailPostReactor(provider: provider, contest: currentState.contest)
    }
}
