//
//  FanAnimalCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/11.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class FanAnimalCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let animal: Animal
        
        init(animal: Animal) {
            self.animal = animal
        }
    }
    
    let initialState: FanAnimalCellReactor.State
    
    init(animal: Animal) {
        initialState = State(animal: animal)
    }
}

extension FanAnimalCellReactor: Equatable {
    static func == (lhs: FanAnimalCellReactor, rhs: FanAnimalCellReactor) -> Bool {
        return lhs.currentState.animal.id == rhs.currentState.animal.id
    }
}
