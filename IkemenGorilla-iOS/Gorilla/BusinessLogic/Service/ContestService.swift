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
}
