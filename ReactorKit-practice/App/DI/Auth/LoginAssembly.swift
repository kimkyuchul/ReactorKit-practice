//
//  LoginAssembly.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import Foundation

import Swinject

struct LoginAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LoginViewReactor.self) { resolver in
            return LoginViewReactor()
        }
        
        container.register(LoginViewController.self) { resolver in
            let reactor = resolver.resolve(LoginViewReactor.self)!
            let viewContoller = LoginViewController()
            viewContoller.reactor = reactor
            return viewContoller
        }
    }
}
