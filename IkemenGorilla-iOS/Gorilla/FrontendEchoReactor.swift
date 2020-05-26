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
    enum Action {
        case updateSendText(String)
        case send
    }
    enum Mutation {
        case setSendText(String)
        case setReturnText(FrontendEcho)
    }
    
    struct State {
        var returnText: String = "display return message"
        var apiStatus: APIStatus = .pending
        var sendText: String = ""
    }
    
    let initialState = FrontendEchoReactor.State()
    let networkProvider = NetworkProvider<FrontendEchoTarget>()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateSendText(let text):
            logger.debug(text)
            return .just(.setSendText(text))
        case .send:
            if currentState.sendText.isEmpty {
                return .empty()
            }
            return Observable.concat(
                loadEcho(text: currentState.sendText).map(Mutation.setReturnText)
            )
        }
    }
    
    private func loadEcho(text: String) -> Observable<FrontendEcho> {
        networkProvider.rx.request(.getEcho(echo: text))
            .filterSuccessfulStatusCodes()
            .map(FrontendEcho.self, using: JSONDecoder())
            .do(onError: { error in
                logger.error(error)
            })
            .asObservable()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setSendText(let text):
            state.sendText = text
        case .setReturnText(let frontendEcho):
            state.returnText = frontendEcho.message
        }
        return state
    }
}

struct FrontendEcho: Codable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "MESSAGE"
    }
}
