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
        let fanAnimal: FanAnimal
        
        init(fanAnimal: FanAnimal) {
            self.fanAnimal = fanAnimal
        }
    }
    
    let initialState: ProfileFanAnimalListCellReactor.State
    
    init(fanAnimal: FanAnimal) {
        initialState = State(fanAnimal: fanAnimal)
    }
}
