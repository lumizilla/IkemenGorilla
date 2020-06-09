//
//  ProfileInfo.swift
//  Gorilla
//
//  Created by admin on 2020/06/06.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileInfoCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let profile: Profile
        
        init(profile: Profile) {
            self.profile = profile
        }
    }
    
    let initialState: ProfileInfoCellReactor.State
    
    init(profile: Profile) {
        initialState = State(profile: profile)
    }
}

extension ProfileInfoCellReactor: Equatable {
    static func == (lhs: ProfileInfoCellReactor, rhs: ProfileInfoCellReactor) -> Bool {
        return lhs.currentState.profile.id == rhs.currentState.profile.id
    }
}
