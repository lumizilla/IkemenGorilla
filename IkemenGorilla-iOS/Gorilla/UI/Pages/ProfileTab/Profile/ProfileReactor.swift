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
    enum Action {
        case createProfileInfoDetailReactor
    }
    enum Mutation {}
    
    struct State {
        var page: Int = 0
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
    
    //Call for user profile details
    func createProfileInfoDetailReactor() -> ProfileDetailReactor {
        return ProfileDetailReactor(provider: provider)
    }
    
    func createProfileVotedContestListReactor() -> ProfileVotedContestListReactor {
        return ProfileVotedContestListReactor(provider: provider)
    }
    
    func createVotedContestReactor() -> VotedContestReactor {
        return VotedContestReactor(provider: provider)
    }
    
    //Shows animals in main profile page
    func createProfileFanAnimalListReactor() -> ProfileFanAnimalListReactor {
        return ProfileFanAnimalListReactor(provider: provider)
    }
    
    //Shows animals in additional page
    func createFanAnimalReactor() -> FanAnimalReactor {
        return FanAnimalReactor(provider: provider)
    }
    
    func createAnimalDetailReactor(fanAnimal: FanAnimal) -> AnimalDetailReactor {
        let zooAnimal = ZooAnimal(id: fanAnimal.id, name: fanAnimal.name, iconUrl: fanAnimal.iconUrl, isFan: fanAnimal.isFan)
        return AnimalDetailReactor(provider: provider, zooAnimal: zooAnimal)
    }
    
    func createProfileLikedZooListReactor() -> ProfileLikedZooListReactor {
        return ProfileLikedZooListReactor(provider: provider)
    }
    
    func createLikedZooReactor() -> LikedZooReactor {
        return LikedZooReactor(provider: provider)
    }
    
    func createProfileContestDetailReactor(contest: Contest) -> ProfileContestDetailReactor {
        return ProfileContestDetailReactor(provider: provider, contest: contest)
    }

}
