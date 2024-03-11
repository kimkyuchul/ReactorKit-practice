//
//  SecondAssembly.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import Foundation

import Swinject

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
