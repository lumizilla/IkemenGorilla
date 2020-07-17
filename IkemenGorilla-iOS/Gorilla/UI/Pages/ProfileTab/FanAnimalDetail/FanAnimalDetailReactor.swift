//
//  FanAnimalDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class FanAnimalDetailReactor: Reactor {
    enum Action {
        case loadCurrentContest
        case loadPastContests
        case loadPost
    }
    enum Mutation {
        case setCurrentContest(Contest?)
        case setPastContestCellReactors([Contest])
        case setPosts([Post])
    }
    
    struct State {
        let animal: Animal
        let zooName: String = "東山動物園"
        var currentContest: Contest?
        let numberOfVoted: Int = 312
        var pastContestCellReactors: [FanAnimalDetailPastContestCellReactor] = []
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
        case .loadCurrentContest:
            return loadCurrentContest().map(Mutation.setCurrentContest)
        case .loadPastContests:
            return loadPastContests().map(Mutation.setPastContestCellReactors)
        case .loadPost:
            return loadPosts().map(Mutation.setPosts)
        }
    }
    
    private func loadAnimal() -> Observable<Animal> {
        logger.warning("no user id from AnimalDetailReactor")
        return provider.animalService.getAnimal(animalId: currentState.animal.id, userId: "1").asObservable()
    }
    
    private func loadCurrentContest() -> Observable<Contest?> {
        return provider.animalService.getContests(animalId: currentState.animal.id, status: .current).asObservable().map { $0.first }
    }
    
    private func loadPastContests() -> Observable<[Contest]> {
        return provider.animalService.getContests(animalId: currentState.animal.id, status: .past).asObservable()
    }
    
    private func loadPosts() -> Observable<[Post]> {
        logger.warning("todo: pagin")
        return provider.animalService.getPosts(animalId: currentState.animal.id, page: 0).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setCurrentContest(let contest):
            state.currentContest = contest
        case .setPastContestCellReactors(let contests):
            state.pastContestCellReactors = contests.map { FanAnimalDetailPastContestCellReactor(contest: $0) }
        case .setPosts(let posts):
            state.posts = posts
        }
        return state
    }
    
    func createPostPhotoCollectionReactor() -> PostPhotoCollectionReactor {
        return PostPhotoCollectionReactor()
    }
}
