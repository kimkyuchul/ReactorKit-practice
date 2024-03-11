//
//  MainCoodinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

class HomeCoodinator: Coodinator, CoordinatorFinishDelegate {
    struct Dependency {
        let navigationController: UINavigationController
        let injector: Injector
    }
    
    private let dependency: Dependency
    var type: CoordinatorType = .home
    var childCoodinators: [Coodinator] = []
    var navigationController: UINavigationController
    weak var finishDelegate: CoordinatorFinishDelegate?
    
   init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
    }
    
    // start 메서드를 통해 MainView를 띄운다.
    func start() {
        let vc = dependency.injector.resolve(ViewController.self)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func showSecond(productId: Int) {
        let dependency = SecondViewCoodinator.Dependency(
          navigationController: navigationController,
          injector: dependency.injector
        )
        
      let secondCoordinator = SecondViewCoodinator(dependency: dependency)
        childCoodinators.append(secondCoordinator)
        secondCoordinator.finishDelegate = self
        secondCoordinator.productId = productId
        secondCoordinator.start()
    }
}

