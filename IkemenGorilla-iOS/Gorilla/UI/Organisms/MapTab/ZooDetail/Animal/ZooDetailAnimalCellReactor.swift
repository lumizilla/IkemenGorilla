//
//  ZooDetailAnimalCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ZooDetailAnimalCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    struct State {
        let animal: Animal
        
        init(animal: Animal) {
            self.animal = animal
        }
    }
    
    let initialState: State
    
    init(animal: Animal) {
        initialState = State(animal: animal)
    }
}

extension ZooDetailAnimalCellReactor: Equatable {
    static func == (lhs: ZooDetailAnimalCellReactor, rhs: ZooDetailAnimalCellReactor) -> Bool {
        return lhs.currentState.animal.id == rhs.currentState.animal.id
    }
}
