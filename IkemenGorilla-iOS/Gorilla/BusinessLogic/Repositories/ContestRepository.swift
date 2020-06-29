//
//  ContestRepository.swift
//  Gorilla
//
//  Created by admin on 2020/06/29.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol ContestRepositoryType {
    func getContests(status: ContestStatus, page: Int) -> Single<[Contest]>
    func getContest(contestId: String) -> Single<ContestDetail>
}

final class ContestRepository: ContestRepositoryType {
    private let networkProvider: NetworkProvider<ContestTarget>
    private let decoder = GorillaDecoder.default
    
    init(networkProvider: NetworkProvider<ContestTarget>) {
        self.networkProvider = networkProvider
    }
    
    func getContests(status: ContestStatus, page: Int) -> Single<[Contest]> {
        networkProvider.rx.request(.getContests(status: status, page: page))
            .filterSuccessfulStatusCodes()
            .map([Contest].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getContest(contestId: String) -> Single<ContestDetail> {
        networkProvider.rx.request(.getContest(contestId: contestId))
            .filterSuccessfulStatusCodes()
            .map(ContestDetail.self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
}
