//
//  FanAnimalReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/11.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class FanAnimalReactor: Reactor {
    enum Action {
        case refresh
        case load
    }
    
    enum Mutation {
        case setAnimalCellReactors([FanAnimal])
        case addAnimalCellReactors([FanAnimal])
        case setPage(Int)
        case setApiStatus(APIStatus)
    }
    
    struct State {
        var animalCellReactors: [FanAnimalCellReactor] = []
        var page: Int = 0
        var isReachedBottom: Bool = false
        var apiStatus: APIStatus = .pending

    }
    
    let initialState: State
    private let provider: ServiceProviderType

    
    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            guard currentState.apiStatus == .pending else { return .empty() }
            return .concat(
                .just(.setApiStatus(.refreshing)),
                load(page: 0).map(Mutation.setAnimalCellReactors),
                .just(.setPage(0)),
                .just(.setApiStatus(.pending))
            )
        case .load:
            guard currentState.apiStatus == .pending && !currentState.isReachedBottom else { return .empty() }
            return .concat(
                .just(.setApiStatus(.loading)),
                load(page: currentState.page+1).map(Mutation.addAnimalCellReactors),
                .just(.setPage(currentState.page+1)),
                .just(.setApiStatus(.pending))
            )
        }
    }
    
    private func load(page: Int) -> Observable<[FanAnimal]> {
        return provider.userService.getAnimals(userId: "5", page: page).asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setAnimalCellReactors(let fanAnimals):
            state.animalCellReactors = fanAnimals.map { FanAnimalCellReactor(fanAnimal: $0) }
            state.isReachedBottom = fanAnimals.count < 8
        case .addAnimalCellReactors(let fanAnimals):
            state.animalCellReactors += fanAnimals.map { FanAnimalCellReactor(fanAnimal: $0) }
            state.isReachedBottom = fanAnimals.count < 8
        case .setPage(let page):
            state.page = page
        case .setApiStatus(let apiStatus):
            state.apiStatus = apiStatus
        }
        return state
    }
    
    func createFanAnimalDetailReactor(indexPath: IndexPath) -> FanAnimalDetailReactor {
        return FanAnimalDetailReactor(provider: provider, fanAnimal: currentState.animalCellReactors[indexPath.row].currentState.fanAnimal)
    }
    
}
