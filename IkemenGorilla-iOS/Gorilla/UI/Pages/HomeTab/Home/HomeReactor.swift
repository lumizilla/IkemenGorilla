//
//  HomeReactor.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class HomeReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {}
    
    let initialState = HomeReactor.State()
    
    func createHomeCurrentContestListReactor() -> HomeCurrentContestListReactor {
        return HomeCurrentContestListReactor()
    }
    
    func createHomePastContestListReactor() -> HomePastContestListReactor {
        return HomePastContestListReactor()
    }
    
    func createHomeRecommendedZooListReactor() -> HomeRecommendedZooListReactor {
        return HomeRecommendedZooListReactor()
    }
    
    func createHomePastContestReactor() -> HomePastContestReactor {
        return HomePastContestReactor()
    }
    
    func createRecommendedZooReactor() -> RecommendedZooReactor {
        return RecommendedZooReactor()
    }
}
