//
//  ProfileContestDetailInfoSponsorCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileContestDetailInfoSponsorCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let sponsor: Sponsor
        
        init(sponsor: Sponsor) {
            self.sponsor = sponsor
        }
    }
    
    let initialState: ProfileContestDetailInfoSponsorCellReactor.State
    
    init(sponsor: Sponsor) {
        initialState = State(sponsor: sponsor)
    }
}

extension ProfileContestDetailInfoSponsorCellReactor: Equatable {
    static func == (lhs: ProfileContestDetailInfoSponsorCellReactor, rhs: ProfileContestDetailInfoSponsorCellReactor) -> Bool {
        return lhs.currentState.sponsor.id == rhs.currentState.sponsor.id
    }
}
