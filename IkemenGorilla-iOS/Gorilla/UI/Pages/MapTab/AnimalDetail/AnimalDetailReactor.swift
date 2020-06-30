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
        case loadAnimal
        case loadPastContests
        case loadPost
    }
    enum Mutation {
        case setAnimal(Animal)
        case setPastContestCellReactors([Contest])
        case setPosts([Post])
    }
    
    struct State {
        let zooAnimal: ZooAnimal
        var animal: Animal?
        let zooName: String = "東山動物園"
        let currentContest: Contest = TestData.contest()
        let numberOfVoted: Int = 312
        var pastContestCellReactors: [AnimalDetailPastContestCellReactor] = []
        var posts: [Post] = []
        
        init(zooAnimal: ZooAnimal) {
            self.zooAnimal = zooAnimal
        }
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, zooAnimal: ZooAnimal) {
        self.provider = provider
        initialState = State(zooAnimal: zooAnimal)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadAnimal:
            return loadAnimal().map(Mutation.setAnimal)
        case .loadPastContests:
            return loadPastContests().map(Mutation.setPastContestCellReactors)
        case .loadPost:
            return loadPosts().map(Mutation.setPosts)
        }
    }
    
    private func loadAnimal() -> Observable<Animal> {
        return .just(TestData.animal())
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
        case .setAnimal(let animal):
            state.animal = animal
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
