//
//  ContestAnimalDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/12.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestAnimalDetailReactor: Reactor {
    enum Action {
        case loadAnimal
        case loadPosts
        case tapVoteButton
    }
    
    enum Mutation {
        case setResponse(ContestAnimalDetailResponse)
        case setPostCellReactors([Post])
        case setIsLoading(Bool)
        case setIsVoted(Bool)
    }
    
    struct State {
        let entry: Entry
        let contestId: String
        var response: ContestAnimalDetailResponse?
        var postCellReactors: [ContestAnimalDetailPostCellReactor] = []
        var isLoading: Bool = false
        var isVoted: Bool = false
    }
    
    let initialState: ContestAnimalDetailReactor.State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, entry: Entry, contestId: String) {
        self.provider = provider
        initialState = State(entry: entry, contestId: contestId)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadAnimal:
            return loadAnimal().map(Mutation.setResponse)
        case .loadPosts:
            guard !currentState.isLoading else { return .empty() }
            return .concat(
                .just(.setIsLoading(true)),
                loadPosts().map(Mutation.setPostCellReactors),
                .just(.setIsLoading(false))
            )
        case .tapVoteButton:
            return .just(.setIsVoted(!currentState.isVoted))
        }
    }
    
    private func loadAnimal() -> Observable<ContestAnimalDetailResponse> {
        logger.warning("no user id")
        return provider.contestService.getAnimal(contestId: currentState.contestId, animalId: currentState.entry.animalId, userId: "1").asObservable()
    }
    
    private func loadPosts() -> Observable<[Post]> {
        return provider.animalService.getPosts(animalId: currentState.entry.animalId, page: 0).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setResponse(let response):
            state.response = response
        case .setPostCellReactors(let posts):
            state.postCellReactors = posts.map { ContestAnimalDetailPostCellReactor(post: $0) }
        case .setIsLoading(let isLoading):
            state.isLoading = isLoading
        case .setIsVoted(let isVoted):
            state.isVoted = isVoted
        }
        return state
    }
    
    func createExplorePostDetailReactor(indexPath: IndexPath) -> ExplorePostDetailReactor {
        let posts = currentState.postCellReactors.compactMap { $0.currentState.post }
        return ExplorePostDetailReactor(provider: provider, startAt: indexPath.row, posts: posts)
    }
}
