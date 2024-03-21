//
//  MainCoodinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

protocol HomeCoodinatorInterface: AnyObject {
    func pushThirdView(argument: Int)
    func pop()
}

final class HomeCoodinator: Coodinator, CoordinatorFinishDelegate {
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
    
    deinit {
        debugPrint("deinit: \(self)")
    }
    
    // start 메서드를 통해 MainView를 띄운다.
    func start() {
        let vc = dependency.injector.resolve(ViewController.self)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSecond(productId: Int) {
        let dependency = SecondViewCoodinator.Dependency(
            navigationController: dependency.navigationController,
            injector: dependency.injector
        )
        
        let secondCoordinator = SecondViewCoodinator(dependency: dependency)
        childCoodinators.append(secondCoordinator)
        secondCoordinator.finishDelegate = self
        secondCoordinator.productId = productId
        secondCoordinator.start()
    }
    
    func printStack() {
        let viewControllers = navigationController.viewControllers
        for (index, viewController) in viewControllers.enumerated() {
            print("\(index): \(Swift.type(of: viewController))")
        }
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }
}

extension HomeCoodinator: HomeCoodinatorInterface {
    func pushThirdView(argument: Int) {
        let vc = dependency.injector.resolve(ThirdViewController.self, argument: argument)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

