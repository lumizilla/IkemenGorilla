//
//  AnimalRepository.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol AnimalRepositoryType {
    func getPosts(animalId: String, page: Int) -> Single<[Post]>
}

final class AnimalRepository: AnimalRepositoryType {
    private let networkProvider: NetworkProvider<AnimalTarget>
    private let decoder = GorillaDecoder.default
    
    init(networkProvider: NetworkProvider<AnimalTarget>) {
        self.networkProvider = networkProvider
    }
    
    func getPosts(animalId: String, page: Int) -> Single<[Post]> {
        networkProvider.rx.request(.getPosts(animalId: animalId, page: page))
            .filterSuccessfulStatusCodes()
            .map([Post].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
}
