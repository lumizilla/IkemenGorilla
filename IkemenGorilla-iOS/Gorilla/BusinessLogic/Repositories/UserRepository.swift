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
    func getAnimals(userId: String, page: Int) -> Single<[Animal]>
    func getZoos(userId: String) -> Single<[Zoo]>
    func getContests(userId: String) -> Single<[Contest]>
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
    
    func getAnimals(userId: String, page: Int) -> Single<[Animal]> {
        networkProvider.rx.request(.getAnimals(userId: userId, page: page))
            .filterSuccessfulStatusCodes()
            .map([Animal].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getZoos(userId: String) -> Single<[Zoo]> {
        networkProvider.rx.request(.getZoos(userId: userId))
            .filterSuccessfulStatusCodes()
            .map([Zoo].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getContests(userId: String) -> Single<[Contest]> {
        networkProvider.rx.request(.getContests(userId: userId))
            .filterSuccessfulStatusCodes()
            .map([Contest].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
}
