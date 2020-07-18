//
//  ExploreSearchResultReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ExploreSearchResultReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let keyword: String
        var posts: [Post] = []
        var apiStatus: APIStatus = .pending
        var page: Int = 0
        
        init(keyword: String) {
            self.keyword = keyword
        }
    }
    
    let initialState: State
    private let provider: ServiceProviderType
    
    init(provider: ServiceProviderType, keyword: String) {
        self.provider = provider
        initialState = State(keyword: keyword)
    }
}
