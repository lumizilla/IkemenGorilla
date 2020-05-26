//
//  FrontendEchoTarget.swift
//  Gorilla
//
//  Created by admin on 2020/05/26.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

enum FrontendEchoTarget {
    case getEcho(echo: String)
}

extension FrontendEchoTarget: TargetType {
    var path: String {
        switch self {
        case .getEcho(_):
            return "/getecho/"
        }
    }
    
    var method: Method {
        switch self {
        case .getEcho(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getEcho(let text):
            let parameters = [
                "echo": text
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
            case .getEcho(_):
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
