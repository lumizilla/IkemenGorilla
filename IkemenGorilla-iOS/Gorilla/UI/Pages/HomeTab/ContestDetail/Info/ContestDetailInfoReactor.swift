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
        case loadContestDetail
        case loadSponsors
    }
    enum Mutation {
        case setContestDetail(ContestDetail)
        case setSponsorCellReactors([Sponsor])
        case setIsLoading(Bool)
    }
    
    struct State {
        let contest: Contest
        var contestDetail: ContestDetail?
        var sponsorCellReactors: [ContestDetailInfoSponsorCellReactor] = []
        var isLoading: Bool = false
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ContestDetailInfoReactor.State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, contest: Contest) {
        self.provider = provider
        initialState = State(contest: contest)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadContestDetail:
            return loadContestDetail().map(Mutation.setContestDetail)
        case .loadSponsors:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                loadSponsors().map(Mutation.setSponsorCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func loadContestDetail() -> Observable<ContestDetail> {
        return provider.contestService.getContest(contestId: currentState.contest.id).asObservable()
    }
    
    private func loadSponsors() -> Observable<[Sponsor]> {
        return provider.contestService.getSponsors(contestId: currentState.contest.id).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setContestDetail(let contestDetail):
            state.contestDetail = contestDetail
        case .setSponsorCellReactors(let sponsors):
            state.sponsorCellReactors = sponsors.map { ContestDetailInfoSponsorCellReactor(sponsor: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
