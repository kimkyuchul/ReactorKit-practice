//
//  LoginCoordinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import UIKit

final class LoginCoordinator: Coodinator, CoordinatorFinishDelegate {
    struct Dependency {
        let navigationController: UINavigationController
        let injector: Injector
    }
    
    private let dependency: Dependency
    var type: CoordinatorType = .login
    var childCoodinators: [Coodinator] = []
    var navigationController: UINavigationController
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
    }
        
    func start() {
        let loginViewController = dependency.injector.resolve(LoginViewController.self)
        loginViewController.coordinator = self
        navigationController.viewControllers = [loginViewController]
        changeRoot(navigationController)
    }
    
    private func changeRoot(_ rootVC: UIViewController, duration: TimeInterval = 1.1) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = rootVC
        sceneDelegate?.window?.makeKeyAndVisible()
        
        guard let window = sceneDelegate?.window else { return }
        
        UIView.transition(
            with: window,
            duration: duration,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
}
