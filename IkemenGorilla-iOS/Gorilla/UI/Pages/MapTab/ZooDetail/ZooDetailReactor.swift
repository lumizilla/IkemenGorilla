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
        case setAnimalCellReactors([ZooAnimal])
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
    
    private func loadAnimals() -> Observable<[ZooAnimal]> {
        logger.warning("no user id")
        return provider.zooService.getAnimals(zooId: currentState.zoo.id, page: 0, userId: "user01").asObservable()
    }
    
    private func loadPosts() -> Observable<[Post]> {
        return provider.zooService.getPosts(zooId: currentState.zoo.id, page: 0).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setZooDetail(let zooDetail):
            state.zooDetail = zooDetail
        case .setAnimalCellReactors(let zooAnimals):
            state.animalCellReactors = zooAnimals.map { ZooDetailAnimalCellReactor(zooAnimal: $0) }
        case .setPostCellReactors(let posts):
            state.postCellReactors = posts.map { ZooDetailPostCellReactor(post: $0) }
        case .setIsFan(let isFan):
            state.zooDetail?.isFavorite = isFan
        }
        return state
    }
    
    func createZooAnimalListReactor() -> ZooAnimalListReactor {
        let zooAnimals = currentState.animalCellReactors.compactMap { $0.currentState.zooAnimal }
        return ZooAnimalListReactor(provider: provider, zoo: currentState.zoo, zooAnimals: zooAnimals)
    }
    
    func createExplorePostDetailReactor(indexPath: IndexPath) -> ExplorePostDetailReactor {
        let posts = currentState.postCellReactors.compactMap { $0.currentState.post }
        return ExplorePostDetailReactor(startAt: indexPath.row, posts: posts)
    }
}
