//
//  LoginViewReactor.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import Foundation

import RxSwift
import RxRelay
import ReactorKit

final class LoginViewReactor: Reactor {
    let initialState = State()
    
    // View로부터 받을 Action을 enum으로 정의
    enum Action {
    }
    
    // View로부터 action을 받은 경우, 해야할 작업단위들을 enum으로 정의
    enum Mutation {
    }
    
    struct State {
    }
}
