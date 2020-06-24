//
//  AnimalDetailReactor.swift
//  Gorilla
//
//  Created by admin on 2020/06/25.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class AnimalDetailReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        let animal: Animal
        let zooName: String = "東山動物園"
        
        init(animal: Animal) {
            self.animal = animal
        }
    }
    
    let initialState: State
    
    init(animal: Animal) {
        initialState = State(animal: animal)
    }
}
