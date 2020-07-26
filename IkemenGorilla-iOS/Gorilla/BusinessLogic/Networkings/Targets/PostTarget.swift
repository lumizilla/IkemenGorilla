//
//  PostTarget.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

enum PostTarget {
    case getPosts(page: Int)
    case searchPosts(keyword: String, page: Int)
}

extension PostTarget: TargetType {
    var path: String {
        switch self {
        case .getPosts(_):
            return "/posts"
        case .searchPosts(_, _):
            return "/search"
        }
    }
    
    var method: Method {
        switch self {
        case .getPosts, .searchPosts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPosts(let page):
            let parameters = [
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .searchPosts(let keyword, let page):
            let parameters = [
                "query": keyword,
                "page": page
                ] as [String : Any]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getPosts, .searchPosts:
            return URLEncoding.queryString
        }
    }
    
    var baseURL: URL {
//        return URL(string: "https://8ca2bc8b-a8b2-432f-95c1-04b81b793ef8.mock.pstmn.io") ?? undefined("endpoint for frontend echo dose not exist")
        return URL(string: "https://ikemengorilla.herokuapp.com") ?? undefined("endpoint for frontend echo dose not exist")
    }
    
    var headers: [String: String]? {
        nil
    }

    var sampleData: Data {
        Data()
    }
}
