//
//  ContestDetailEntryReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailEntryReactor: Reactor {
    enum Action {
        case refresh
        case load
    }
    enum Mutation {
        case setEntryCellReactors([Entry])
        case addEntryCellReactors([Entry])
        case setApiStatus(APIStatus)
        case setPage(Int)
        case setDidReachedBottom(Bool)
    }
    
    struct State {
        let contest: Contest
        var entryCellReactors: [ContestDetailEntryCellReactor] = []
        var apiStatus: APIStatus = .pending
        var page: Int = 0
        var didReachedBottom: Bool = false
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: ContestDetailEntryReactor.State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, contest: Contest) {
        self.provider = provider
        initialState = State(contest: contest)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            guard currentState.apiStatus == .pending else { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                load(page: 0).map(Mutation.setEntryCellReactors),
                .just(.setPage(0)),
                .just(.setApiStatus(.pending))
            )
        case .load:
            guard currentState.apiStatus == .pending && !currentState.didReachedBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                load(page: currentState.page + 1).map(Mutation.addEntryCellReactors),
                .just(.setPage(currentState.page + 1)),
                .just(.setApiStatus(.pending))
            )
        }
    }
    
    private func load(page: Int) -> Observable<[Entry]> {
        return provider.contestService.getAnimals(contestId: currentState.contest.id, page: page).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEntryCellReactors(let entries):
            state.entryCellReactors = entries.map { ContestDetailEntryCellReactor(entry: $0) }
        case .addEntryCellReactors(let entries):
            state.entryCellReactors += entries.map { ContestDetailEntryCellReactor(entry: $0) }
            state.didReachedBottom = entries.count == 0
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        case .setPage(let page):
            state.page = page
        case .setDidReachedBottom(let didReachedBottom):
            state.didReachedBottom = didReachedBottom
        }
        return state
    }
    
    func createContestAnimalDetailReactor(indexPath: IndexPath) -> ContestAnimalDetailReactor {
        return ContestAnimalDetailReactor(provider: provider, entry: currentState.entryCellReactors[indexPath.row].currentState.entry, contest: currentState.contest)
    }
}
