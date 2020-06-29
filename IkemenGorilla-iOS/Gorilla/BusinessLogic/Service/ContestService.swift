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
    func getAwards(contestId: String) -> Single<[Award]>
    func getResults(contestId: String) -> Single<[ContestResult]>
    func getAnimal(contestId: String, animalId: String, userId: String) -> Single<Animal>
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
    
    func getAwards(contestId: String) -> Single<[Award]> {
        contestRepository.getAwards(contestId: contestId)
    }
    
    func getResults(contestId: String) -> Single<[ContestResult]> {
        contestRepository.getResults(contestId: contestId)
    }
    
    func getAnimal(contestId: String, animalId: String, userId: String) -> Single<Animal> {
        contestRepository.getAnimal(contestId: contestId, animalId: animalId, userId: userId)
    }
}
