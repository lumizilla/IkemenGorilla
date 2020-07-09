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
        let zoo: Zoo
        
        init(zoo: Zoo) {
            self.zoo = zoo
        }
    }
    
    let initialState: HomeRecommendedZooListCellReactor.State
    
    init(zoo: Zoo) {
        initialState = State(zoo: zoo)
    }
}
