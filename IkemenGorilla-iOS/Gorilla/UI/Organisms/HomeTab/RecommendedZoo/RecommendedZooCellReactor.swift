//
//  RecommendedZooCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class RecommendedZooCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let recommendedZoo: RecommendedZoo
        
        init(recommendedZoo: RecommendedZoo) {
            self.recommendedZoo = recommendedZoo
        }
    }
    
    let initialState: RecommendedZooCellReactor.State
    
    init(recommendedZoo: RecommendedZoo) {
        initialState = State(recommendedZoo: recommendedZoo)
    }
}

extension RecommendedZooCellReactor: Equatable {
    static func == (lhs: RecommendedZooCellReactor, rhs: RecommendedZooCellReactor) -> Bool {
        return lhs.currentState.recommendedZoo.id == rhs.currentState.recommendedZoo.id
    }
}
