//
//  LikedZooCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class LikedZooCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let recommendedZoo: RecommendedZoo
        
        init(recommendedZoo: RecommendedZoo) {
            self.recommendedZoo = recommendedZoo
        }
    }
    
    let initialState: LikedZooCellReactor.State
    
    init(recommendedZoo: RecommendedZoo) {
        initialState = State(recommendedZoo: recommendedZoo)
    }
}

extension LikedZooCellReactor: Equatable {
    static func == (lhs: LikedZooCellReactor, rhs: LikedZooCellReactor) -> Bool {
        return lhs.currentState.recommendedZoo.id == rhs.currentState.recommendedZoo.id
    }
}
