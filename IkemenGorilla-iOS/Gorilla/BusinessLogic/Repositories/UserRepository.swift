//
//  UserRepository.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol UserRepositoryType {
    func getUser(userId: String) -> Single<Bool>
}

final class UserRepository: UserRepositoryType {
    private let networkProvider: NetworkProvider<UserTarget>
    private let decoder = GorillaDecoder.default
    
    init(networkProvider: NetworkProvider<UserTarget>) {
        self.networkProvider = networkProvider
    }
    
    func getUser(userId: String) -> Single<Bool> {
        networkProvider.rx.request(.getUser(userId: userId))
            .filterSuccessfulStatusCodes()
            .map(Bool.self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
}
