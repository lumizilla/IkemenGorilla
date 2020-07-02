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
        let zooAnimal: ZooAnimal
        
        init(zooAnimal: ZooAnimal) {
            self.zooAnimal = zooAnimal
        }
    }
    
    let initialState: State
    
    init(zooAnimal: ZooAnimal) {
        initialState = State(zooAnimal: zooAnimal)
    }
}

extension ZooDetailAnimalCellReactor: Equatable {
    static func == (lhs: ZooDetailAnimalCellReactor, rhs: ZooDetailAnimalCellReactor) -> Bool {
        return lhs.currentState.zooAnimal.id == rhs.currentState.zooAnimal.id
    }
}
