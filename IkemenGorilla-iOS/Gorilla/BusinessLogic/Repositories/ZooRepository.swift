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
}
