//
//  SecondViewCoodinator.swift
//  ReactorKit-practice
//
//  Created by testtest macBook Air on 3/8/24.
//

import UIKit

class SecondViewCoodinator: Coodinator {
    struct Dependency {
        let navigationController: UINavigationController
        let injector: Injector
    }
    
    private let dependency: Dependency
    var type: CoordinatorType = .second
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoodinators: [Coodinator] = []
    
    var navigationController: UINavigationController
    
    init(dependency: Dependency) {
         self.dependency = dependency
         self.navigationController = dependency.navigationController
     }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
    
    func start() {
        let vc = SecondViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinish() {
      finish()
      navigationController.popViewController(animated: true)
    }
}
