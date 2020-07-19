//
//  UserTarget.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

enum UserTarget {
    case getUser(userId: String)
    case getAnimals(userId: String, page: Int)
    case getZoos(userId: String, page: Int)
    case getContests(userId: String, page: Int)
}

extension UserTarget: TargetType {
    var path: String {
        switch self {
        case .getUser(let userId):
            return "/users/\(userId)"
        case .getAnimals(let userId, _):
            return "/users/\(userId)/fans"
        case .getZoos(let userId, _):
            return "/users/\(userId)/zoos"
        case .getContests(let userId, _):
            return "/users/\(userId)/contests"
        }
    }
    
    var method: Method {
        switch self {
        case .getUser, .getZoos, .getAnimals, .getContests:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getAnimals(_ , let page):
            let parameters = [
                "page": page
            ] as [String : Any]
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getContests(_ , let page):
            let parameters = [
                "page": page
            ] as [String : Any]
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getZoos(_ , let page):
            let parameters = [
                "page": page
            ] as [String : Any]
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getUser:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getAnimals, .getContests, .getZoos:
            return URLEncoding.queryString
        case .getUser:
            return URLEncoding.default
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://ikemengorilla.herokuapp.com") ?? undefined("endpoint for frontend echo dose not exist")
    }
    
    var headers: [String: String]? {
        nil
    }

    var sampleData: Data {
        Data()
    }
}
