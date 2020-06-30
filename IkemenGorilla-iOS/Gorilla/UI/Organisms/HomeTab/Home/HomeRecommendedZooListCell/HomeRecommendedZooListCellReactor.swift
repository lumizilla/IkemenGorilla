//
//  HomeRecommendedZooListCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeRecommendedZooListCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let recommendedZoo: RecommendedZoo
        
        init(recommendedZoo: RecommendedZoo) {
            self.recommendedZoo = recommendedZoo
        }
    }
    
    let initialState: HomeRecommendedZooListCellReactor.State
    
    init(recommendedZoo: RecommendedZoo) {
        initialState = State(recommendedZoo: recommendedZoo)
    }
}
