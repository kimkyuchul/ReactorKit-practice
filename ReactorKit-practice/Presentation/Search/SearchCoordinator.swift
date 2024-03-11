//
//  SearchCoordinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import UIKit

final class SearchCoordinator: Coodinator {
    struct Dependency {
        let navigationController: UINavigationController
        let injector: Injector
    }
    
    private let dependency: Dependency
    var type: CoordinatorType = .search
    var childCoodinators: [Coodinator] = []
    var navigationController: UINavigationController
    weak var finishDelegate: CoordinatorFinishDelegate?
    
   init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
    }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
    
    // start 메서드를 통해 SearchView를 띄운다.
    func start() {
        let vc = dependency.injector.resolve(SearchViewController.self)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
