//
//  ServiceProvider.swift
//  Gorilla
//
//  Created by admin on 2020/06/29.
//  Copyright © 2020 admin. All rights reserved.
//

protocol ServiceProviderType: AnyObject {
    var contestService: ContestServiceType { get set }
    var animalService: AnimalServiceType { get set }
    var zooService: ZooServiceType { get set }
    var postService: PostServiceType { get set }
    var userService: UserServiceType { get set }
    var storeService: StoreServiceType { get set }
}

final class ServiceProvider: ServiceProviderType {
    
    private lazy var contestRepository = ContestRepository(networkProvider: NetworkProvider<ContestTarget>())
    private lazy var animalRepository = AnimalRepository(networkProvider: NetworkProvider<AnimalTarget>())
    private lazy var zooRepository = ZooRepository(networkProvider: NetworkProvider<ZooTarget>())
    private lazy var postRepository = PostRepository(networkProvider: NetworkProvider<PostTarget>())
    private lazy var userRepository = UserRepository(networkProvider: NetworkProvider<UserTarget>())
    
    lazy var contestService: ContestServiceType = ContestService(provider: self, contestRepository: contestRepository)
    lazy var animalService: AnimalServiceType = AnimalService(provider: self, animalRepository: animalRepository)
    lazy var zooService: ZooServiceType = ZooService(provider: self, zooRepository: zooRepository)
    lazy var postService: PostServiceType = PostService(provider: self, postRepository: postRepository)
    lazy var userService: UserServiceType = UserService(provider: self, userRepository: userRepository)
    lazy var storeService: StoreServiceType = StoreService(provider: self)
}
