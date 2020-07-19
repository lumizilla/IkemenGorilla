//
//  ProfileContestDetailResultReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileContestDetailResultReactor: Reactor {
    enum Action {
        case load
    }
    
    enum Mutation {
        case setAwardCellReactors([Award])
        case setResultCellReactors([ContestResult])
        case setIsLoading(Bool)
    }
    
    struct State {
        let contest: Contest
        var awardCellReactors: [ProfileContestDetailResultAwardCellReactor] = []
        var resultCellReactors: [ProfileContestDetailResultVoteCellReactor] = []
        var isLoading: Bool = false
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ProfileContestDetailResultReactor.State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, contest: Contest) {
        self.provider = provider
        initialState = State(contest: contest)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                loadAwards().map(Mutation.setAwardCellReactors),
                loadContestResults().map(Mutation.setResultCellReactors),
                .just(.setIsLoading(false))
            )
        }
    }
    
    private func loadAwards() -> Observable<[Award]> {
        return provider.contestService.getAwards(contestId: currentState.contest.id).asObservable()
    }
    
    private func loadContestResults() -> Observable<[ContestResult]> {
        return provider.contestService.getResults(contestId: currentState.contest.id).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAwardCellReactors(let awards):
            state.awardCellReactors = awards.map { ProfileContestDetailResultAwardCellReactor(award: $0) }
        case .setResultCellReactors(let contestResults):
            state.resultCellReactors = contestResults.map { ProfileContestDetailResultVoteCellReactor(contestResult: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    func createVotedDetailReactorFromAward(indexPath: IndexPath) -> VotedAnimalDetailReactor {
        let award = currentState.awardCellReactors[indexPath.row].currentState.award
        let entry = Entry(animalId: award.animalId, name: award.animalName, iconUrl: award.iconUrl, zooName: "")
        return VotedAnimalDetailReactor(provider: provider, entry: entry, contestId: currentState.contest.id)
    }
    
    func createVotedDetailReactorFromResult(indexPath: IndexPath) -> VotedAnimalDetailReactor {
        let result = currentState.resultCellReactors[indexPath.row].currentState.contestResult
        let entry = Entry(animalId: result.animalId, name: result.animalName, iconUrl: result.iconUrl, zooName: "")
        return VotedAnimalDetailReactor(provider: provider, entry: entry, contestId: currentState.contest.id)
    }
}
