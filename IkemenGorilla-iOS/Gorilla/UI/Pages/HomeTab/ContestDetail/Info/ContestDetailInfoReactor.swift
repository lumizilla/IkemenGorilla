//
//  ContestDetailInfoReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailInfoReactor: Reactor {
    enum Action {
        case loadSponsors
    }
    enum Mutation {
        case setSponsorCellReactors([Sponsor])
        case setIsLoading(Bool)
    }
    
    struct State {
        let contest: Contest
        var sponsorCellReactors: [ContestDetailInfoSponsorCellReactor] = []
        var isLoading: Bool = false
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ContestDetailInfoReactor.State
    
    init(contest: Contest) {
        initialState = State(contest: contest)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadSponsors:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                load().map(Mutation.setSponsorCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func load() -> Observable<[Sponsor]> {
        return .just(TestData.sponsors(count: 8))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setSponsorCellReactors(let sponsors):
            state.sponsorCellReactors = sponsors.map { ContestDetailInfoSponsorCellReactor(sponsor: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
