//
//  SecondViewCoodinator.swift
//  ReactorKit-practice
//
//  Created by testtest macBook Air on 3/8/24.
//

import UIKit

final class SecondViewCoodinator: Coodinator {
    struct Dependency {
        let navigationController: UINavigationController
        let injector: Injector
    }
    
    private let dependency: Dependency
    var type: CoordinatorType = .second
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoodinators: [Coodinator] = []
    var productId: Int?
    
    var navigationController: UINavigationController
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
    }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
    
    func start() {
        guard let productId else { return }
        let viewController = dependency.injector.resolve(SecondViewController.self, argument: productId)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish() {
        finish()
        navigationController.popViewController(animated: true)
    }
    
    func goToLogin() {
        finish()
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

public extension Notification.Name {
    static let accessTokenDidExpired = Notification.Name("accessTokenDidExpired")
    static let logout = Notification.Name("logout")
}
