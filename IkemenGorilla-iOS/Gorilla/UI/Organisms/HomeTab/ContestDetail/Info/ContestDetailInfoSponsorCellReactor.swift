//
//  ContestDetailInfoSponsorCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailInfoSponsorCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let sponsor: Sponsor
        
        init(sponsor: Sponsor) {
            self.sponsor = sponsor
        }
    }
    
    let initialState: ContestDetailInfoSponsorCellReactor.State
    
    init(sponsor: Sponsor) {
        initialState = State(sponsor: sponsor)
    }
}

extension ContestDetailInfoSponsorCellReactor: Equatable {
    static func == (lhs: ContestDetailInfoSponsorCellReactor, rhs: ContestDetailInfoSponsorCellReactor) -> Bool {
        return lhs.currentState.sponsor.id == rhs.currentState.sponsor.id
    }
}
