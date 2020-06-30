//
//  AnimalService.swift
//  Gorilla
//
//  Created by admin on 2020/06/30.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

protocol AnimalServiceType {
    func getPosts(animalId: String, page: Int) -> Single<[Post]>
    func getAnimal(animalId: String, userId: String) -> Single<Animal>
    func getContests(animalId: String, status: ContestStatus) -> Single<[Contest]>
}

final class AnimalService: BaseService, AnimalServiceType {
    private let animalRepository: AnimalRepositoryType
    
    init(provider: ServiceProviderType, animalRepository: AnimalRepositoryType) {
        self.animalRepository = animalRepository
        super.init(provider: provider)
    }
    
    func getPosts(animalId: String, page: Int) -> Single<[Post]> {
        animalRepository.getPosts(animalId: animalId, page: page)
    }
    
    func getAnimal(animalId: String, userId: String) -> Single<Animal> {
        animalRepository.getAnimal(animalId: animalId, userId: userId)
    }
    
    func getContests(animalId: String, status: ContestStatus) -> Single<[Contest]> {
        animalRepository.getContests(animalId: animalId, status: status)
    }
}
