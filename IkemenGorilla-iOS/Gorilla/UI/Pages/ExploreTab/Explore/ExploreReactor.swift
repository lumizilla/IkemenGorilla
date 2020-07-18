//
//  ExploreReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ExploreReactor: Reactor {
    enum Action {
        case refresh
        case load
    }
    
    enum Mutation {
        case setPosts([Post])
        case addPosts([Post])
        case setPage(Int)
        case setApiStatus(APIStatus)
    }
    
    struct State {
        var posts: [Post] = []
        var page: Int = 0
        var apiStatus: APIStatus = .pending
        var didReachedBottom: Bool = false
    }
    
    var initialState: State
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
                load(page: 0).map(Mutation.setPosts),
                .just(.setPage(0)),
                .just(.setApiStatus(.pending))
            )
        case .load:
            guard currentState.apiStatus == .pending && !currentState.didReachedBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                load(page: currentState.page+1).map(Mutation.addPosts),
                .just(.setPage(currentState.page+1)),
                .just(.setApiStatus(.pending))
            )
        }
    }
    
    private func load(page: Int) -> Observable<[Post]> {
        logger.warning("todo: paging from ExploreReactor")
        return provider.postService.getPosts(page: page).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setPosts(let posts):
            state.posts = posts
            state.didReachedBottom = posts.count < 24
        case .addPosts(let posts):
            state.posts += posts
            state.didReachedBottom = posts.count < 24
        case .setPage(let page):
            state.page = page
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }
    
    func createExplorePostDetailReactor(indexPath: IndexPath) -> ExplorePostDetailReactor {
        return ExplorePostDetailReactor(provider: provider, startAt: indexPath.row, posts: currentState.posts)
    }
}
