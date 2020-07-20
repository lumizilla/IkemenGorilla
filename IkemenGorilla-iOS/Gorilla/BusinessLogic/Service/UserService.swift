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
    func getAnimals(userId: String, page: Int) -> Single<[FanAnimal]>
    func getZoos(userId: String, page: Int) -> Single<[RecommendedZoo]>
    func getContests(userId: String, page: Int) -> Single<[Contest]>
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
    
    func getZoos(userId: String, page: Int) -> Single<[RecommendedZoo]> {
        userRepository.getZoos(userId: userId, page: page)
    }
    
    func getAnimals(userId: String, page: Int) -> Single<[FanAnimal]> {
        userRepository.getAnimals(userId: userId, page: page)
    }
    
    func getContests(userId: String, page: Int) -> Single<[Contest]> {
        userRepository.getContests(userId: userId, page: page)
    }
}
