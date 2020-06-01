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
        let entry: Entry
        
        init(entry: Entry) {
            self.entry = entry
        }
    }
    
    let initialState: ContestDetailEntryAnimalCellReactor.State
    
    init(entry: Entry) {
        initialState = State(entry: entry)
    }
}
