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
    
    func createProfileVotedContestListReactor() -> ProfileVotedContestListReactor {
        return ProfileVotedContestListReactor()
    }
    
    func createVotedContestReactor() -> VotedContestReactor {
        return VotedContestReactor()
    }
    
    func createProfileFanAnimalListReactor() -> ProfileFanAnimalListReactor {
        return ProfileFanAnimalListReactor()
    }
    
    func createFanAnimalReactor() -> FanAnimalReactor {
        return FanAnimalReactor()
    }
    
    func createProfileLikedZooListReactor() -> ProfileLikedZooListReactor {
        return ProfileLikedZooListReactor()
    }
    
    func createLikedZooReactor() -> LikedZooReactor {
        return LikedZooReactor()
    }
    
    func createProfileContestDetailReactor(contest: Contest) -> ContestDetailReactor {
        return ContestDetailReactor(contest: contest)
    }
}
