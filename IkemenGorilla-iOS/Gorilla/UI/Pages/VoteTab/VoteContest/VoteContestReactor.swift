//
//  VoteContestReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/27.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class VoteContestReactor: Reactor {
    enum Action {
        case refresh
        case load
    }
    enum Mutation {
        case setContestCellReactors([Contest])
        case addContestCellReactors([Contest])
        case setApiStatus(APIStatus)
        case setPage(Int)
    }
    
    struct State {
        var contestCellReactors: [VoteContestCellReactor] = []
        var page: Int = 0
        var didReachedBottom: Bool = false
        var apiStatus: APIStatus = .pending
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            guard currentState.apiStatus == .pending else { return .empty() }
            return .concat(
                .just(.setApiStatus(.refreshing)),
                load(page: 0).map(Mutation.setContestCellReactors),
                .just(.setPage(0)),
                .just(.setApiStatus(.pending))
            )
        case .load:
            guard currentState.apiStatus == .pending && !currentState.didReachedBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.refreshing)),
                load(page: currentState.page+1).map(Mutation.addContestCellReactors),
                .just(.setPage(currentState.page+1)),
                .just(.setApiStatus(.pending))
            )
        }
    }
    
    private func load(page: Int) -> Observable<[Contest]> {
        return provider.contestService.getContests(status: .current, page: page).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setContestCellReactors(let contests):
            state.contestCellReactors = contests.map { VoteContestCellReactor(contest: $0) }
            state.didReachedBottom = contests.count < 8
        case .addContestCellReactors(let contests):
            state.contestCellReactors += contests.map { VoteContestCellReactor(contest: $0) }
            state.didReachedBottom = contests.count < 8
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        case .setPage(let page):
            state.page = page
        }
        return state
    }
    
    func createVoteContestDetailReactor(indexPath: IndexPath) -> VoteContestDetailReactor {
        return VoteContestDetailReactor(provider: provider, contest: currentState.contestCellReactors[indexPath.row].currentState.contest, entry: nil)
    }
}
