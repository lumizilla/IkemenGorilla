//
//  VoteContestDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class VoteContestDetailReactor: Reactor {
    enum Action {
        case refresh
        case load
        case selectEntry(IndexPath)
    }
    enum Mutation {
        case setEntryCellReactors([Entry])
        case addEntryCellReactors([Entry])
        case setVoteEntry(Entry?)
        case setPage(Int)
        case setApiStatus(APIStatus)
    }
    
    struct State {
        let contest: Contest
        var entryCellReactors: [ContestDetailEntryCellReactor] = []
        var voteEntry: Entry?
        var page: Int = 0
        var apiStatus: APIStatus = .pending
        var didReachedBottom: Bool = false
        
        init(contest: Contest) {
            self.contest = contest
        }
    }
    
    let initialState: State
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
                .just(.setApiStatus(.refreshing)),
                load(page: 0).map(Mutation.setEntryCellReactors),
                .just(.setPage(0)),
                .just(.setApiStatus(.pending))
            )
        case .load:
            guard currentState.apiStatus == .pending && !currentState.didReachedBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                load(page: currentState.page+1).map(Mutation.addEntryCellReactors),
                .just(.setPage(currentState.page+1)),
                .just(.setApiStatus(.pending))
            )
        case .selectEntry(let indexPath):
            return .just(.setVoteEntry(currentState.entryCellReactors[indexPath.row].currentState.entry))
        }
    }
    
    private func load(page: Int) -> Observable<[Entry]> {
        logger.warning("todo: paging from VoteContestDetailReactor")
        return provider.contestService.getAnimals(contestId: currentState.contest.id, page: page).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEntryCellReactors(let entries):
            state.entryCellReactors = entries.map { ContestDetailEntryCellReactor(entry: $0) }
            state.didReachedBottom = entries.count < 8
        case .addEntryCellReactors(let entries):
            state.entryCellReactors += entries.map { ContestDetailEntryCellReactor(entry: $0) }
            state.didReachedBottom = entries.count < 8
        case .setVoteEntry(let entry):
            state.voteEntry = entry
        case .setPage(let page):
            state.page = page
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }
}
