//
//  ContestDetailResultReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailResultReactor: Reactor {
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
        var awardCellReactors: [ContestDetailResultAwardCellReactor] = []
        var resultCellReactors: [ContestDetailResultVoteCellReactor] = []
        var isLoading: Bool = false
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ContestDetailResultReactor.State
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
        if currentState.contest.status == "current" {
            return .empty()
        }
        return provider.contestService.getAwards(contestId: currentState.contest.id).asObservable()
    }
    
    private func loadContestResults() -> Observable<[ContestResult]> {
        return provider.contestService.getResults(contestId: currentState.contest.id).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAwardCellReactors(let awards):
            state.awardCellReactors = awards.map { ContestDetailResultAwardCellReactor(award: $0) }
        case .setResultCellReactors(let contestResults):
            state.resultCellReactors = contestResults.map { ContestDetailResultVoteCellReactor(contestResult: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
    
    func createContestAnimalDetailReactorFromAward(indexPath: IndexPath) -> ContestAnimalDetailReactor {
        let award = currentState.awardCellReactors[indexPath.row].currentState.award
        let entry = Entry(animalId: award.animalId, name: award.animalName, iconUrl: award.iconUrl, zooName: "")
        return ContestAnimalDetailReactor(provider: provider, entry: entry, contest: currentState.contest)
    }
    
    func createContestAnimalDetailReactorFromResult(indexPath: IndexPath) -> ContestAnimalDetailReactor {
        let result = currentState.resultCellReactors[indexPath.row].currentState.contestResult
        let entry = Entry(animalId: result.animalId, name: result.animalName, iconUrl: result.iconUrl, zooName: "")
        return ContestAnimalDetailReactor(provider: provider, entry: entry, contest: currentState.contest)
    }
}
