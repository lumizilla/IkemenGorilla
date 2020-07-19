//
//  ProfileLikedZooListCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileLikedZooListCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let recommendedZoo: RecommendedZoo
        
        init(recommendedZoo: RecommendedZoo) {
            self.recommendedZoo = recommendedZoo
        }
    }
    
    let initialState: ProfileLikedZooListCellReactor.State
    
    init(recommendedZoo: RecommendedZoo) {
        initialState = State(recommendedZoo: recommendedZoo)
    }
}
