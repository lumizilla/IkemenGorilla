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
}

extension ZooTarget: TargetType {
     var path: String {
        switch self {
        case .getZoos:
            return "/zoos"
        case .getZoo(let zooId, _):
            return "/zoos/\(zooId)"
        }
    }
    
    var method: Method {
        switch self {
        case .getZoos, .getZoo:
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
        case .getZoos:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getZoo:
            return URLEncoding.queryString
        case .getZoos:
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

