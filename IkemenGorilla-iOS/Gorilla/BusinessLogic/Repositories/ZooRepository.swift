//
//  ZooRepository.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol ZooRepositoryType {
    func getZoos() -> Single<[Zoo]>
    func getZoo(zooId: String, userId: String) -> Single<ZooDetail>
    func getAnimals(zooId: String, page: Int, userId: String) -> Single<[ZooAnimal]>
}

final class ZooRepository: ZooRepositoryType {
    private let networkProvider: NetworkProvider<ZooTarget>
    private let decoder = GorillaDecoder.default
    
    init(networkProvider: NetworkProvider<ZooTarget>) {
        self.networkProvider = networkProvider
    }
    
    func getZoos() -> Single<[Zoo]> {
        networkProvider.rx.request(.getZoos)
            .filterSuccessfulStatusCodes()
            .map([Zoo].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getZoo(zooId: String, userId: String) -> Single<ZooDetail> {
        networkProvider.rx.request(.getZoo(zooId: zooId, userId: userId))
            .filterSuccessfulStatusCodes()
            .map(ZooDetail.self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getAnimals(zooId: String, page: Int, userId: String) -> Single<[ZooAnimal]> {
        networkProvider.rx.request(.getAnimals(zooId: zooId, page: page, userId: userId))
            .filterSuccessfulStatusCodes()
            .map([ZooAnimal].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
}
