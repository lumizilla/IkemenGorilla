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
        case loadEntries
        case selectEntry(IndexPath)
    }
    enum Mutation {
        case setEntryCellReactors([Entry])
        case setVoteEntry(Entry?)
    }
    
    struct State {
        let contest: Contest
        var entryCellReactors: [ContestDetailEntryCellReactor] = []
        var voteEntry: Entry?
        
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
        case .loadEntries:
            return loadEntries().map(Mutation.setEntryCellReactors)
        case .selectEntry(let indexPath):
            return .just(.setVoteEntry(currentState.entryCellReactors[indexPath.row].currentState.entry))
        }
    }
    
    private func loadEntries() -> Observable<[Entry]> {
        logger.warning("todo: paging from VoteContestDetailReactor")
        return provider.contestService.getAnimals(contestId: currentState.contest.id, page: 0).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setEntryCellReactors(let entries):
            state.entryCellReactors = entries.map { ContestDetailEntryCellReactor(entry: $0) }
        case .setVoteEntry(let entry):
            state.voteEntry = entry
        }
        return state
    }
}
