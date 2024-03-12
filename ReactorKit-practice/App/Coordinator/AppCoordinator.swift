//
//  AppCoordinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

protocol AppCoordinator: Coodinator {
    func showTabBarFlow()
    func showLoginFlow()
    func getChildCoordinator(_ type: CoordinatorType) -> Coodinator?
}

final class DefaultAppCoodinator: AppCoordinator {
    struct Dependency {
        let navigationController: UINavigationController
        let injector: Injector
    }
    
    private let dependency: Dependency
    var childCoodinators: [Coodinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType = .app
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
        addTokenObserver()
    }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
    
    func start() {
        setTabBarCoordinator()
        showTabBarFlow()
        
//        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
//        switch isLoggedIn {
//        case true:      
//            setTabBarCoordinator()
//            showTabBarFlow()
//        case false:
//            showLoginFlow()
//        }
    }
    
    // 탭바 플로우
    func showTabBarFlow() {
        if getChildCoordinator(.tabBar) == nil { setTabBarCoordinator() }
        let tabBarCoordinator = getChildCoordinator(.tabBar) as! TabBarCoordinator
        tabBarCoordinator.finishDelegate = self
        tabBarCoordinator.start()
    }
    
    // 로그인 플로우
    func showLoginFlow() {
        let dependency = LoginCoordinator.Dependency(
            navigationController: navigationController,
            injector: dependency.injector
        )
        let loginCoordinator = LoginCoordinator(dependency: dependency)
        childCoodinators.append(loginCoordinator)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
    }
    
    func setTabBarCoordinator() {
        let dependency = TabBarCoordinator.Dependency(
            navigationController: navigationController,
            injector: dependency.injector
        )
        let tabBarCoordinator = TabBarCoordinator(dependency: dependency)
        childCoodinators.append(tabBarCoordinator)
    }
    
    func getChildCoordinator(_ type: CoordinatorType) -> Coodinator? {
        var childCoordinator: Coodinator? = nil
        
        switch type {
        case .tabBar:
            // childCoordinators 배열에서 MainCoordinator 타입의 첫 번째 인스턴스를 찾아 childCoordinator 변수에 할당
            // first(where:) 메서드는 주어진 조건을 만족하는 배열의 첫 번째 요소를 반환합니다. 여기서는 $0 is MainCoordinator 조건을 사용하여 배열 내의 요소 중 MainCoordinator 타입의 요소를 찾는다.
            childCoordinator = childCoodinators.first(where: { $0 is TabBarCoordinator})
        default:
            break
        }
        
        return childCoordinator
    }
}

// 자식 코디네이터가 종료되었을 때 실행할 메서드
extension DefaultAppCoodinator: CoordinatorFinishDelegate {}

private extension DefaultAppCoodinator {
  // MARK: Methods
  func addTokenObserver() {
      NotificationCenter.default.addObserver(
          self,
          selector: #selector(resetWhenLogout),
          name: .logout,
          object: nil
      )
  }

    @objc private func resetWhenLogout() {
    showLoginFlow() 
  }
}
