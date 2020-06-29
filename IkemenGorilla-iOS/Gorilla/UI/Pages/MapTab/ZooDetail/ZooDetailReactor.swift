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
        case loadZooDetail
        case loadAnimals
        case loadPosts
        case tapHeartButton
    }
    enum Mutation {
        case setZooDetail(ZooDetail)
        case setAnimalCellReactors([Animal])
        case setPostCellReactors([Post])
        case setIsFan(Bool)
    }
    
    struct State {
        let zoo: Zoo
        var zooDetail: ZooDetail?
        var animalCellReactors: [ZooDetailAnimalCellReactor] = []
        var postCellReactors: [ZooDetailPostCellReactor] = []
        
        init(zoo: Zoo) {
            self.zoo = zoo
        }
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, zoo: Zoo) {
        self.provider = provider
        initialState = State(zoo: zoo)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadZooDetail:
            return loadZooDetail().map(Mutation.setZooDetail)
        case .loadAnimals:
            return loadAnimals().map(Mutation.setAnimalCellReactors)
        case .loadPosts:
            return loadPosts().map(Mutation.setPostCellReactors)
        case .tapHeartButton:
            guard let isFavorite = currentState.zooDetail?.isFavorite else { return .empty() }
            return .just(.setIsFan(!isFavorite))
        }
    }
    
    private func loadZooDetail() -> Observable<ZooDetail> {
        logger.warning("no user id")
        return provider.zooService.getZoo(zooId: currentState.zoo.id, userId: "user01").asObservable()
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
        case .setZooDetail(let zooDetail):
            state.zooDetail = zooDetail
        case .setAnimalCellReactors(let animals):
            state.animalCellReactors = animals.map { ZooDetailAnimalCellReactor(animal: $0) }
        case .setPostCellReactors(let posts):
            state.postCellReactors = posts.map { ZooDetailPostCellReactor(post: $0) }
        case .setIsFan(let isFan):
            state.zooDetail?.isFavorite = isFan
        }
        return state
    }
    
    func createZooAnimalReactor() -> ZooAnimalReactor {
        return ZooAnimalReactor(zoo: currentState.zoo)
    }
}
