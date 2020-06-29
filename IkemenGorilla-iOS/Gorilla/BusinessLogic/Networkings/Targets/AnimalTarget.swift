//
//  AnimalTarget.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

enum AnimalTarget {
    case getPosts(animalId: String, page: Int)
}

extension AnimalTarget: TargetType {
     var path: String {
        switch self {
        case .getPosts(let animalId, _):
            return "/animals/\(animalId)/posts"
        }
    }
    
    var method: Method {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPosts(_, let page):
            let parameters = [
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
            case .getPosts:
                return URLEncoding.queryString
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://testlumi.herokuapp.com") ?? undefined("endpoint for frontend echo dose not exist")
    }
    
    var headers: [String: String]? {
        nil
    }

    var sampleData: Data {
        Data()
    }
}
