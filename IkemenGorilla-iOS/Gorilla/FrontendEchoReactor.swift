//
//  FrontendEchoReactor.swift
//  Gorilla
//
//  Created by admin on 2020/05/26.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class FrontendEchoReactor: Reactor {
    enum Action {}
    enum Mutation {}
    
    struct State {
        var echo: String = "yeah"
    }
    
    let initialState = FrontendEchoReactor.State()
}
