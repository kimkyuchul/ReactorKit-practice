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

struct SecondAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SecondViewModel.self) { resolver, id in
            return SecondViewModel(id: id)
        }
        
        container.register(SecondViewController.self) { resolver, id in
            let viewModel = SecondViewModel(id: id)
            let viewContoller = SecondViewController(viewModel: viewModel)
            return viewContoller
        }
    }
}

struct ThirdAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ThirdViewModel.self) { resolver, id in
            return ThirdViewModel(id: id)
        }
        
        container.register(ThirdViewController.self) { resolver, id in
            let viewModel = ThirdViewModel(id: id)
            let viewContoller = ThirdViewController(viewModel: viewModel)
            return viewContoller
        }
    }
}
