//
//  PostRepository.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol PostRepositoryType {
    func getPosts(page: Int) -> Single<[Post]>
    func searchPosts(keyword: String, page: Int) -> Single<[Post]>
}

final class PostRepository: PostRepositoryType {
    private let networkProvider: NetworkProvider<PostTarget>
    private let decoder = GorillaDecoder.default
    
    init(networkProvider: NetworkProvider<PostTarget>) {
        self.networkProvider = networkProvider
    }
    
    func getPosts(page: Int) -> Single<[Post]> {
        networkProvider.rx.request(.getPosts(page: page))
            .filterSuccessfulStatusCodes()
            .map([Post].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func searchPosts(keyword: String, page: Int) -> Single<[Post]> {
        networkProvider.rx.request(.searchPosts(keyword: keyword, page: page))
            .filterSuccessfulStatusCodes()
            .map([Post].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
}
