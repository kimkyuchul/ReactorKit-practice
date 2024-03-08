//
//  HomeAssembly.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import Foundation

import Swinject

struct HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ViewReactor.self) { resolver in
            return ViewReactor()
        }
        
        container.register(ViewController.self) { resolver in
            let reactor = resolver.resolve(ViewReactor.self)!
            let viewContoller = ViewController()
            viewContoller.reactor = reactor
            return viewContoller
        }
    }
}
