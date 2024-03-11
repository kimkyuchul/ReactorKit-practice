//
//  SearchAssembly.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import Foundation

import Swinject

struct SearchAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SearchViewReactor.self) { resolver in
            return SearchViewReactor()
        }
        
        container.register(SearchViewController.self) { resolver in
            let reactor = resolver.resolve(SearchViewReactor.self)!
            let viewContoller = SearchViewController()
            viewContoller.reactor = reactor
            return viewContoller
        }
    }
}
