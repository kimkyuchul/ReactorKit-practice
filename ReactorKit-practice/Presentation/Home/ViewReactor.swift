//
//  ViewReactor.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 2/4/24.
//

import Foundation

import RxSwift
import RxRelay
import ReactorKit

final class ViewReactor: Reactor {
    // 가장 첫 상태를 나타내는 initialState
    let initialState = State()
    
    // View로부터 받을 Action을 enum으로 정의
    enum Action {
        case increase
        case decrease
    }
    
    // View로부터 action을 받은 경우, 해야할 작업단위들을 enum으로 정의
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    // 현재 상태를 기록하고 있으며, View에서 해당 정보를 사용하여 UI업데이트 및 Reactor에서 image를 얻어올때 page정보들을 저장
    struct State {
          var value = 0
          var isLoading = false
      }
    
    // Action이 들어온 경우, 어떤 처리를 할건지 분기
    // Action이나 State와 달리 Mutation은 리액터 클래스 밖으로 노출되지 않습니다. 대신, 클래스 내부에서 Action과 State를 연결하는 역할을 수행
    // 네트워킹이나 비동기로직 등의 사이드 이펙트를 처리
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat(([
                Observable.just(.setLoading(true)),
                Observable.just(.increaseValue),
                Observable.just(.setLoading(false))
            ]))
        case .decrease:
            return Observable.concat([
                Observable.just(.setLoading(true)),
                Observable.just(.decreaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(.setLoading(false))
            ])
        }
    }
    
    // Mutation을 방출하면 그 값이 reduce() 함수로 전달됩니다. reduce() 함수는 이전 상태와 Mutation을 받아서 다음 상태를 반환
    // Mutation -> State
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let bool):
            newState.isLoading = bool
        }
        return newState
    }
}
