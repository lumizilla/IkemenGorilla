//
//  ZooDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ZooDetailReactor: Reactor {
    enum Action {
        case loadAnimals
        case loadPosts
        case tapHeartButton
    }
    enum Mutation {
        case setAnimalCellReactors([Animal])
        case setPostCellReactors([Post])
        case setIsFan(Bool)
    }
    
    struct State {
        let zoo: Zoo
        var animalCellReactors: [ZooDetailAnimalCellReactor] = []
        var postCellReactors: [ZooDetailPostCellReactor] = []
        var isFan: Bool = false
        
        init(zoo: Zoo) {
            self.zoo = zoo
        }
    }
    
    let initialState: State
    
    init(zoo: Zoo) {
        initialState = State(zoo: zoo)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadAnimals:
            return loadAnimals().map(Mutation.setAnimalCellReactors)
        case .loadPosts:
            return loadPosts().map(Mutation.setPostCellReactors)
        case .tapHeartButton:
            return .just(.setIsFan(!currentState.isFan))
        }
    }
    
    private func loadAnimals() -> Observable<[Animal]> {
        return .just(TestData.animals(count: 8))
    }
    
    private func loadPosts() -> Observable<[Post]> {
        return .just(TestData.posts(count: 12))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAnimalCellReactors(let animals):
            state.animalCellReactors = animals.map { ZooDetailAnimalCellReactor(animal: $0) }
        case .setPostCellReactors(let posts):
            state.postCellReactors = posts.map { ZooDetailPostCellReactor(post: $0) }
        case .setIsFan(let isFan):
            state.isFan = isFan
        }
        return state
    }
}
