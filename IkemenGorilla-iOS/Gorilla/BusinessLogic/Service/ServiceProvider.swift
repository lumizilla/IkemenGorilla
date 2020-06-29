//
//  ServiceProvider.swift
//  Gorilla
//
//  Created by admin on 2020/06/29.
//  Copyright © 2020 admin. All rights reserved.
//

protocol ServiceProviderType: AnyObject {
    var contestService: ContestServiceType { get set }
}

final class ServiceProvider: ServiceProviderType {
    
    private lazy var contestRepository = ContestRepository(networkProvider: NetworkProvider<ContestTarget>())
    
    lazy var contestService: ContestServiceType = ContestService(provider: self, contestRepository: contestRepository)
}
