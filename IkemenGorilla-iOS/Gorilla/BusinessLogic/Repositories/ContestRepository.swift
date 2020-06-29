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
    func getSponsors(contestId: String) -> Single<[Sponsor]>
    func getAnimals(contestId: String, page: Int) -> Single<[Entry]>
    func getPosts(contestId: String, page: Int) -> Single<[Post]>
    func getAwards(contestId: String) -> Single<[Award]>
    func getResults(contestId: String) -> Single<[ContestResult]>
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
    
    func getSponsors(contestId: String) -> Single<[Sponsor]> {
        networkProvider.rx.request(.getSponsors(contestId: contestId))
            .filterSuccessfulStatusCodes()
            .map([Sponsor].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getAnimals(contestId: String, page: Int) -> Single<[Entry]> {
        networkProvider.rx.request(.getAnimals(contestId: contestId, page: page))
            .filterSuccessfulStatusCodes()
            .map([Entry].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getPosts(contestId: String, page: Int) -> Single<[Post]> {
        networkProvider.rx.request(.getPosts(contestId: contestId, page: page))
            .filterSuccessfulStatusCodes()
            .map([Post].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getAwards(contestId: String) -> Single<[Award]> {
        networkProvider.rx.request(.getAwards(contestId: contestId))
            .filterSuccessfulStatusCodes()
            .map([Award].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
    
    func getResults(contestId: String) -> Single<[ContestResult]> {
        networkProvider.rx.request(.getResults(contestId: contestId))
            .filterSuccessfulStatusCodes()
            .map([ContestResult].self, using: decoder)
            .do(onError: { error in
                logger.error(error)
            })
    }
}
