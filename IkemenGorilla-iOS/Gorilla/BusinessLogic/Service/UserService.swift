//
//  UserService.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol UserServiceType {
    func getUser(userId: String) -> Single<UserDetail>
    func getAnimals(userId: String, page: Int) -> Single<[Animal]>
    func getZoos(userId: String) -> Single<[Zoo]>
    func getContests(userId: String) -> Single<[Contest]>
}

final class UserService: BaseService, UserServiceType {
    private let userRepository: UserRepositoryType
    
    init(provider: ServiceProviderType, userRepository: UserRepositoryType) {
        self.userRepository = userRepository
        super.init(provider: provider)
    }
    
    func getUser(userId: String) -> Single<UserDetail> {
        userRepository.getUser(userId: userId)
    }
    
    func getZoos(userId: String) -> Single<[Zoo]> {
        userRepository.getZoos(userId: userId)
    }
    
    func getAnimals(userId: String, page: Int) -> Single<[Animal]> {
        userRepository.getAnimals(userId: userId, page: page)
    }
    
    func getContests(userId: String) -> Single<[Contest]> {
        userRepository.getContests(userId: userId)
    }
}
