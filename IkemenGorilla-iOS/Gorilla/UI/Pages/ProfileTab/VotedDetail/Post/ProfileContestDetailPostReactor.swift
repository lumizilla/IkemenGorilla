//
//  ProfileContestDetailPostReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileContestDetailPostReactor: Reactor {
    enum Action {
        case refresh
        case load
    }
    
    enum Mutation {
        case setPostCellReactors([Post])
        case addPostCellReactors([Post])
        case setApiStatus(APIStatus)
        case setPage(Int)
        case setDidReachedBottom(Bool)
    }
    
    struct State {
        let contest: Contest
        var postCellReactors: [ProfileContestDetailPostCellReactor] = []
        var page: Int = 0
        var apiStatus: APIStatus = .pending
        var didReachedBottom: Bool = false
    }
    
    let initialState: ProfileContestDetailPostReactor.State
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
                load(page: 0).map(Mutation.setPostCellReactors),
                .just(.setPage(0)),
                .just(.setApiStatus(.pending))
            )
        case .load:
            guard currentState.apiStatus == .pending && !currentState.didReachedBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                load(page: currentState.page+1).map(Mutation.addPostCellReactors),
                .just(.setPage(currentState.page+1)),
                .just(.setApiStatus(.pending))
            )
        }
    }
    
    private func load(page: Int) -> Observable<[Post]> {
        return provider.contestService.getPosts(contestId: currentState.contest.id, page: page).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setPostCellReactors(let posts):
            state.postCellReactors = posts.map { ProfileContestDetailPostCellReactor(post: $0) }
        case .addPostCellReactors(let posts):
            state.postCellReactors += posts.map { ProfileContestDetailPostCellReactor(post: $0) }
            state.didReachedBottom = posts.count == 0
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        case .setPage(let page):
            state.page = page
        case .setDidReachedBottom(let didReachedBottom):
            state.didReachedBottom = didReachedBottom
        }
        return state
    }
    
    func createExplorePostDetailReactor(indexPath: IndexPath) -> ExplorePostDetailReactor {
        let posts = currentState.postCellReactors.compactMap { $0.currentState.post }
        return ExplorePostDetailReactor(provider: provider, startAt: indexPath.row, posts: posts)
    }
}
