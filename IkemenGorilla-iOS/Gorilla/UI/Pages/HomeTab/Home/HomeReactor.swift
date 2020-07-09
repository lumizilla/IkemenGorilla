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
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
    
    func createHomeCurrentContestListReactor() -> HomeCurrentContestListReactor {
        return HomeCurrentContestListReactor(provider: provider)
    }
    
    func createHomePastContestListReactor() -> HomePastContestListReactor {
        return HomePastContestListReactor()
    }
    
    func createHomeRecommendedZooListReactor() -> HomeRecommendedZooListReactor {
        return HomeRecommendedZooListReactor(provider: provider)
    }
    
    func createPastContestReactor() -> PastContestReactor {
        return PastContestReactor(provider: provider)
    }
    
    func createRecommendedZooReactor() -> RecommendedZooReactor {
        return RecommendedZooReactor(provider: provider)
    }
    
    func createContestDetailReactor(contest: Contest) -> ContestDetailReactor {
        return ContestDetailReactor(provider: provider, contest: contest)
    }
}
