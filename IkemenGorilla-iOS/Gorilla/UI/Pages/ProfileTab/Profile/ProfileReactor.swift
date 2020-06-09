//
//  ProfileReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {}
    
    let initialState = ProfileReactor.State()
    
    func createProfileInfoListReactor() -> ProfileInfoReactor {
        return ProfileInfoReactor()
    }
    
    func createProfileCurrentContestListReactor() -> ProfileCurrentContestListReactor {
        return ProfileCurrentContestListReactor()
    }
    
    func createProfileContestDetailReactor(contest: Contest) -> ContestDetailReactor {
        return ContestDetailReactor(contest: contest)
    }
}
