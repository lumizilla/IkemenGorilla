//
//  AnimalDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/25.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class AnimalDetailReactor: Reactor {
    enum Action {
        case loadPastContests
        case loadPost
    }
    enum Mutation {
        case setPastContestCellReactors([Contest])
        case setPosts([Post])
    }
    
    struct State {
        let animal: Animal
        let zooName: String = "東山動物園"
        let currentContest: Contest = TestData.contest()
        let numberOfVoted: Int = 312
        var pastContestCellReactors: [AnimalDetailPastContestCellReactor] = []
        var posts: [Post] = []
        
        init(animal: Animal) {
            self.animal = animal
        }
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, animal: Animal) {
        self.provider = provider
        initialState = State(animal: animal)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadPastContests:
            return loadPastContests().map(Mutation.setPastContestCellReactors)
        case .loadPost:
            return loadPosts().map(Mutation.setPosts)
        }
    }
    
    private func loadPastContests() -> Observable<[Contest]> {
        return .just(TestData.contests(count: 5))
    }
    
    private func loadPosts() -> Observable<[Post]> {
        return .just(TestData.posts(count: 12))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setPastContestCellReactors(let contests):
            state.pastContestCellReactors = contests.map { AnimalDetailPastContestCellReactor(contest: $0) }
        case .setPosts(let posts):
            state.posts = posts
        }
        return state
    }
    
    func createPostPhotoCollectionReactor() -> PostPhotoCollectionReactor {
        return PostPhotoCollectionReactor()
    }
}
