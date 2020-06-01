//
//  ContestDetailEntryAnimalCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ContestDetailEntryAnimalCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let animal: Animal
        
        init(animal: Animal) {
            self.animal = animal
        }
    }
    
    let initialState: ContestDetailEntryAnimalCellReactor.State
    
    init(animal: Animal) {
        initialState = State(animal: animal)
    }
}
