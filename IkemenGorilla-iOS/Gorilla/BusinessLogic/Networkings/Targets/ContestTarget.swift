//
//  ContestTarget.swift
//  Gorilla
//
//  Created by admin on 2020/06/29.
//  Copyright © 2020 admin. All rights reserved.
//

import Moya

enum ContestStatus {
    case current
    case past
}

enum ContestTarget {
    case getContests(status: ContestStatus, page: Int)
    case getContest(contestId: String)
    case getSponsors(contestId: String)
    case getAnimals(contestId: String, page: Int)
    case getPosts(contestId: String, page: Int)
    case getAwards(contestId: String)
    case getResults(contestId: String)
    case getAnimal(contestId: String, animalId: String, userId: String)
    case vote(contestId: String, animalId: String, userId: String)
}

extension ContestTarget: TargetType {
    var path: String {
        switch self {
        case .getContests(_, _):
            return "/contests"
        case .getContest(let contestId):
            return "/contests/\(contestId)"
        case .getSponsors(let contestId):
            return "/contests/\(contestId)/sponsors"
        case .getAnimals(let contestId, _):
            return "/contests/\(contestId)/animals"
        case .getPosts(let contestId, _):
            return "/contests/\(contestId)/posts"
        case .getAwards(let contestId):
            return "/contests/\(contestId)/awards"
        case .getResults(let contestId):
            return "/contests/\(contestId)/results"
        case .getAnimal(let contestId, let animalId, _):
            return "/contests/\(contestId)/animals/\(animalId)"
        case .vote(let contestId, _, _):
            return "/contests/\(contestId)/vote"
        }
    }
    
    var method: Method {
        switch self {
        case .getContests, .getContest, .getSponsors, .getAnimals, .getPosts, .getAwards, .getResults, .getAnimal:
            return .get
        case .vote:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getContests(let status, let page):
            let parameters = [
                "status": status,
                "page": page
                ] as [String : Any]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getAnimals(_, let page):
            let parameters = [
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getPosts(_, let page):
            let parameters = [
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getAnimal(_, _, let userId):
            let parameters = [
                "user_id": userId
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        case .getContest, .getSponsors, .getAwards, .getResults:
            return .requestPlain
        case .vote(_, let animalId, let userId):
            let parameters = [
                "animal_id": animalId,
                "user_id": userId
            ]
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .getContests, .getAnimals, .getPosts, .getAnimal:
            return URLEncoding.queryString
        case .getContest, .getSponsors, .getAwards, .getResults:
            return URLEncoding.default
        case .vote:
            return JSONEncoding.default
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
