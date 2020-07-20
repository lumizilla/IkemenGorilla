//
//  ProfileContestDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileContestDetailReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let contest: Contest
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ProfileContestDetailReactor.State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, contest: Contest) {
        self.provider = provider
        initialState = State(contest: contest)
    }
    
    func createProfileContestDetailInfoReactor() -> ProfileContestDetailInfoReactor {
        return ProfileContestDetailInfoReactor(provider: provider, contest: currentState.contest)
    }
    
    func createProfileContestDetailEntryReactor() -> ProfileContestDetailEntryReactor {
        return ProfileContestDetailEntryReactor(provider: provider, contest: currentState.contest)
    }
    
    func createProfileContestDetailPostReactor() -> ProfileContestDetailPostReactor {
        return ProfileContestDetailPostReactor(provider: provider, contest: currentState.contest)
    }
    
    func createProfileContestDetailResultReactor() -> ProfileContestDetailResultReactor {
        return ProfileContestDetailResultReactor(provider: provider, contest: currentState.contest)
    }
}
