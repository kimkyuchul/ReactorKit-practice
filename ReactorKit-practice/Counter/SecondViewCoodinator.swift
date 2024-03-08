//
//  SecondViewCoodinator.swift
//  ReactorKit-practice
//
//  Created by testtest macBook Air on 3/8/24.
//

import UIKit

class SecondViewCoodinator: Coodinator {
    var childCoodinators: [Coodinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SecondViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
