//
//  RecommendedZooCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeRecommendedZooCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let zoo: Zoo
        
        init(zoo: Zoo) {
            self.zoo = zoo
        }
    }
    
    let initialState: HomeRecommendedZooCellReactor.State
    
    init(zoo: Zoo) {
        initialState = State(zoo: zoo)
    }
}

extension HomeRecommendedZooCellReactor: Equatable {
    static func == (lhs: HomeRecommendedZooCellReactor, rhs: HomeRecommendedZooCellReactor) -> Bool {
        return lhs.currentState.zoo.id == rhs.currentState.zoo.id
    }
}
