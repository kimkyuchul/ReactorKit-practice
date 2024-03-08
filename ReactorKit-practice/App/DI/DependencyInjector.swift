//
//  DependencyInjector.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import Foundation

import Swinject


/// DI 대상 등록
protocol DependencyAssemblable {
    // 연관된 서비스를 그룹화하는 기능을 제공하기 위해서 Swinject 에서는 Assembly 라는 프로토콜을 제공
    func assemble(_ assemblyList: [Assembly])
    func register<T>(_ serviceType: T.Type, _ object: T)
}

/// DI 등록한 서비스 사용
protocol DependencyResolvable {
    func resolve<T>(_ serviceType: T.Type) -> T
}

typealias Injector = DependencyAssemblable & DependencyResolvable

// 의존성 주압을 담당하는 인젝터
final class DependencyInjector: Injector {
    // DI Container 로 이해
    //  Container에 원하는 serviceType을 register 하면 된다. 이후에 필요한 곳에서 resolve를 통해 해당 타입에 맞는 객체가 생성
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    // Assembly 프로토콜을 준수하는 객체들을 등록
    func assemble(_ assemblyList: [Assembly]) {
        assemblyList.forEach { assembly in
            assembly.assemble(container: container)
        }
    }
    
    // register : Container에 사용할 프로토콜 등록
    func register<T>(_ serviceType: T.Type, _ object: T) {
        container.register(serviceType) { _ in object }
    }
    
    // resolve : 클래스 사용
    func resolve<T>(_ serviceType: T.Type) -> T {
        container.resolve(serviceType)!
    }
}
