//
//  ContestService.swift
//  Gorilla
//
//  Created by admin on 2020/06/29.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol ContestServiceType {
    func getContests(status: ContestStatus, page: Int) -> Single<[Contest]>
    func getContest(contestId: String) -> Single<ContestDetail>
    func getSponsors(contestId: String) -> Single<[Sponsor]>
    func getAnimals(contestId: String, page: Int) -> Single<[Entry]>
    func getPosts(contestId: String, page: Int) -> Single<[Post]>
}

final class ContestService: BaseService, ContestServiceType {
    private let contestRepository: ContestRepositoryType
    
    init(provider: ServiceProviderType, contestRepository: ContestRepositoryType) {
        self.contestRepository = contestRepository
        super.init(provider: provider)
    }
    
    func getContests(status: ContestStatus, page: Int) -> Single<[Contest]> {
        contestRepository.getContests(status: status, page: page)
    }
    
    func getContest(contestId: String) -> Single<ContestDetail> {
        contestRepository.getContest(contestId: contestId)
    }
    
    func getSponsors(contestId: String) -> Single<[Sponsor]> {
        contestRepository.getSponsors(contestId: contestId)
    }
    
    func getAnimals(contestId: String, page: Int) -> Single<[Entry]> {
        contestRepository.getAnimals(contestId: contestId, page: page)
    }
    
    func getPosts(contestId: String, page: Int) -> Single<[Post]> {
        contestRepository.getPosts(contestId: contestId, page: page)
    }
}
