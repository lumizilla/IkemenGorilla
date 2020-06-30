//
//  ZooTarget.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

enum ZooTarget {
    case getZoos
    case getZoo(zooId: String, userId: String)
    case getAnimals(zooId: String, page: Int, userId: String)
    case getPosts(zooId: String, page: Int)
    case getRecommendedZoos
}

extension ZooTarget: TargetType {
     var path: String {
        switch self {
        case .getZoos:
            return "/zoos"
        case .getZoo(let zooId, _):
            return "/zoos/\(zooId)"
        case .getAnimals(let zooId, _, _):
            return "/zoos/\(zooId)/animals"
        case .getPosts(let zooId, _):
            return "/zoos/\(zooId)/posts"
        case .getRecommendedZoos:
            return "/zoos/recommended"
        }
    }
    
    var method: Method {
        switch self {
        case .getZoos, .getZoo, .getAnimals, .getPosts, .getRecommendedZoos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getZoo(_, let userId):
            let parameters = [
                "user_id": userId
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getAnimals(_ , let page, let userId):
            let parameters = [
                "page": page,
                "user_id": userId
                ] as [String : Any]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getPosts(_, let page):
            let parameters = [
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getZoos, .getRecommendedZoos:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getZoo, .getAnimals, .getPosts:
            return URLEncoding.queryString
        case .getZoos, .getRecommendedZoos:
            return URLEncoding.default
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://8ca2bc8b-a8b2-432f-95c1-04b81b793ef8.mock.pstmn.io") ?? undefined("endpoint for frontend echo dose not exist")
    }
    
    var headers: [String: String]? {
        nil
    }

    var sampleData: Data {
        Data()
    }
}

