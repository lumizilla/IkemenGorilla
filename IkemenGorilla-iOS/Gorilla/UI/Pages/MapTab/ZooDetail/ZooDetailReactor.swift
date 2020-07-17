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
        case refreshPosts
        case loadPosts
        case tapHeartButton
    }
    enum Mutation {
        case setZooDetail(ZooDetail)
        case setAnimalCellReactors([ZooAnimal])
        case setPosts([Post])
        case addPosts([Post])
        case setIsFan(Bool)
        case setPage(Int)
        case setApiStatus(APIStatus)
    }
    
    struct State {
        let zoo: Zoo
        var zooDetail: ZooDetail?
        var animalCellReactors: [ZooDetailAnimalCellReactor] = []
        var posts: [Post] = []
        var page: Int = 0
        var didReachedBottom: Bool = false
        var apiStatus: APIStatus = .pending
        
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
        case .refreshPosts:
            guard currentState.apiStatus == .pending else { return .empty() }
            return .concat(
                .just(.setApiStatus(.refreshing)),
                loadPosts(page: 0).map(Mutation.setPosts),
                .just(.setPage(0)),
                .just(.setApiStatus(.pending))
            )
        case .loadPosts:
            guard currentState.apiStatus == .pending && !currentState.didReachedBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.refreshing)),
                loadPosts(page: currentState.page+1).map(Mutation.addPosts),
                .just(.setPage(currentState.page+1)),
                .just(.setApiStatus(.pending))
            )
        case .tapHeartButton:
            guard let isFavorite = currentState.zooDetail?.isFavorite else { return .empty() }
            return .just(.setIsFan(!isFavorite))
        }
    }
    
    private func loadZooDetail() -> Observable<ZooDetail> {
        logger.warning("no user id")
        return provider.zooService.getZoo(zooId: currentState.zoo.id, userId: "1").asObservable()
    }
    
    private func loadAnimals() -> Observable<[ZooAnimal]> {
        logger.warning("no user id")
        return provider.zooService.getAnimals(zooId: currentState.zoo.id, page: 0, userId: "1").asObservable()
    }
    
    private func loadPosts(page: Int) -> Observable<[Post]> {
        return provider.zooService.getPosts(zooId: currentState.zoo.id, page: page).asObservable()
    }
    
    private func updateIsFan() -> Observable<Bool> {
        return .just(true)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setZooDetail(let zooDetail):
            state.zooDetail = zooDetail
        case .setAnimalCellReactors(let zooAnimals):
            state.animalCellReactors = zooAnimals.map { ZooDetailAnimalCellReactor(zooAnimal: $0) }
        case .setPosts(let posts):
            state.posts = posts
            state.didReachedBottom = posts.count < 12
        case .addPosts(let posts):
            state.posts += posts
            state.didReachedBottom = posts.count < 12
        case .setIsFan(let isFan):
            state.zooDetail?.isFavorite = isFan
            if isFan {
                state.zooDetail?.numberOfFavorites += 1
            } else {
                state.zooDetail?.numberOfFavorites -= 1
            }
        case .setPage(let page):
            state.page = page
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }
    
    func createZooAnimalListReactor() -> ZooAnimalListReactor {
        let zooAnimals = currentState.animalCellReactors.compactMap { $0.currentState.zooAnimal }
        return ZooAnimalListReactor(provider: provider, zoo: currentState.zoo, zooAnimals: zooAnimals)
    }
    
    func createAnimalDetailReactor(indexPath: IndexPath) -> AnimalDetailReactor {
        return AnimalDetailReactor(provider: provider, zooAnimal: currentState.animalCellReactors[indexPath.row].currentState.zooAnimal)
    }
    
    func createPostPhotoCollectionReactor() -> PostPhotoCollectionReactor {
        return PostPhotoCollectionReactor()
    }
    
    func createExplorePostDetailReactor(indexPath: IndexPath) -> ExplorePostDetailReactor {
        let posts = currentState.posts
        return ExplorePostDetailReactor(provider: provider, startAt: indexPath.row, posts: posts)
    }
}
