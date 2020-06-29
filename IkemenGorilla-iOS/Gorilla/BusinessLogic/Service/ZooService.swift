//
//  ZooService.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol ZooServiceType {
    func getZoos() -> Single<[Zoo]>
    func getZoo(zooId: String, userId: String) -> Single<ZooDetail>
}

final class ZooService: BaseService, ZooServiceType {
    private let zooRepository: ZooRepositoryType
    
    init(provider: ServiceProviderType, zooRepository: ZooRepositoryType) {
        self.zooRepository = zooRepository
        super.init(provider: provider)
    }
    
    func getZoos() -> Single<[Zoo]> {
        zooRepository.getZoos()
    }
    
    func getZoo(zooId: String, userId: String) -> Single<ZooDetail> {
        zooRepository.getZoo(zooId: zooId, userId: userId)
    }
}
