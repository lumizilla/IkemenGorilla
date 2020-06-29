//
//  ProfileFanAnimalListCellReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/11.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class ProfileFanAnimalListCellReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let animal: Animal
        
        init(animal: Animal) {
            self.animal = animal
        }
    }
    
    let initialState: ProfileFanAnimalListCellReactor.State
    
    init(animal: Animal) {
        initialState = State(animal: animal)
    }
}
