//
//  PostService.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol PostServiceType {
    func getPosts(page: Int) -> Single<[Post]>
    func searchPosts(keyword: String, page: Int) -> Single<[Post]>
}

final class PostService: BaseService, PostServiceType {
    private let postRepository: PostRepositoryType
    
    init(provider: ServiceProviderType, postRepository: PostRepositoryType) {
        self.postRepository = postRepository
        super.init(provider: provider)
    }
    
    func getPosts(page: Int) -> Single<[Post]> {
        postRepository.getPosts(page: page)
    }
    
    func searchPosts(keyword: String, page: Int) -> Single<[Post]> {
        postRepository.searchPosts(keyword: keyword, page: page)
    }
}
