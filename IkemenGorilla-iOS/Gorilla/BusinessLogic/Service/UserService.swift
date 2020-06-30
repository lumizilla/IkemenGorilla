//
//  UserService.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol UserServiceType {
    func getUser(userId: String) -> Single<Bool>
}

final class UserService: BaseService, UserServiceType {
    private let userRepository: UserRepositoryType
    
    init(provider: ServiceProviderType, userRepository: UserRepositoryType) {
        self.userRepository = userRepository
        super.init(provider: provider)
    }
    
    func getUser(userId: String) -> Single<Bool> {
        userRepository.getUser(userId: userId)
    }
}
