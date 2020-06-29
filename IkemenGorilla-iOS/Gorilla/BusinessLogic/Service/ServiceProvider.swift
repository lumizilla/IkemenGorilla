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
}

final class ServiceProvider: ServiceProviderType {
    
    private lazy var contestRepository = ContestRepository(networkProvider: NetworkProvider<ContestTarget>())
    private lazy var animalRepository = AnimalRepository(networkProvider: NetworkProvider<AnimalTarget>())
    
    lazy var contestService: ContestServiceType = ContestService(provider: self, contestRepository: contestRepository)
    lazy var animalService: AnimalServiceType = AnimalService(provider: self, animalRepository: animalRepository)
}
