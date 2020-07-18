//
//  ExploreSearchResultReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ExploreSearchResultReactor: Reactor {
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
        let keyword: String
        var posts: [Post] = []
        var apiStatus: APIStatus = .pending
        var page: Int = 0
        var didReachBottom: Bool = false
        
        init(keyword: String) {
            self.keyword = keyword
        }
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, keyword: String) {
        self.provider = provider
        initialState = State(keyword: keyword)
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
            guard currentState.apiStatus == .pending && !currentState.didReachBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                load(page: currentState.page+1).map(Mutation.addPosts),
                .just(.setPage(currentState.page+1)),
                .just(.setApiStatus(.pending))
            )
        }
    }
    
    private func load(page: Int) -> Observable<[Post]> {
        return provider.postService.searchPosts(keyword: currentState.keyword).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setPosts(let posts):
            state.posts = posts
            state.didReachBottom = posts.count < 24
        case .addPosts(let posts):
            state.posts += posts
            state.didReachBottom = posts.count < 24
        case .setPage(let page):
            state.page = page
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }
    
    func createPostPhotoCollectionReactor() -> PostPhotoCollectionReactor {
        return PostPhotoCollectionReactor()
    }
}
