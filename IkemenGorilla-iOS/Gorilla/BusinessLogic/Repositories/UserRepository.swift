//
//  UserRepository.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol UserRepositoryType {
    func getUser(userId: String) -> Single<UserDetail>
    func getAnimals(userId: String, page: Int) -> Single<[FanAnimal]>
    func getZoos(userId: String, page: Int) -> Single<[RecommendedZoo]>
    func getContests(userId: String, page: Int) -> Single<[Contest]>
}

final class UserRepository: UserRepositoryType {
    private let networkProvider: NetworkProvider<UserTarget>
    private let decoder = GorillaDecoder.default
    
    init(networkProvider: NetworkProvider<UserTarget>) {
        self.networkProvider = networkProvider
    }
    
    func getUser(userId: String) -> Single<UserDetail> {
        networkProvider.rx.request(.getUser(userId: userId))
            .filterSuccessfulStatusCodes()
            .map(UserDetail.self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getAnimals(userId: String, page: Int) -> Single<[FanAnimal]> {
        networkProvider.rx.request(.getAnimals(userId: userId, page: page))
            .filterSuccessfulStatusCodes()
            .map([FanAnimal].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getZoos(userId: String, page: Int) -> Single<[RecommendedZoo]> {
        networkProvider.rx.request(.getZoos(userId: userId, page: page))
            .filterSuccessfulStatusCodes()
            .map([RecommendedZoo].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getContests(userId: String, page: Int) -> Single<[Contest]> {
        networkProvider.rx.request(.getContests(userId: userId, page: page))
            .filterSuccessfulStatusCodes()
            .map([Contest].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
}
