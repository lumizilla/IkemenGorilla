//
//  RecommendKeywordCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class RecommendKeywordCellReactor: Reactor {
    
    enum Action {}
    enum Mutation {}
    
    struct State {
        let keyword: String
        
        init(keyword: String) {
            self.keyword = keyword
        }
    }
    
    let initialState: RecommendKeywordCellReactor.State
    
    init(keyword: String) {
        initialState = State(keyword: keyword)
    }
}

extension RecommendKeywordCellReactor: Equatable {
    static func == (lhs: RecommendKeywordCellReactor, rhs: RecommendKeywordCellReactor) -> Bool {
        return lhs.currentState.keyword == rhs.currentState.keyword
    }
}
