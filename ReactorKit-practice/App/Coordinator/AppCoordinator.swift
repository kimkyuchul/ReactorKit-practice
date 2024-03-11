//
//  AppCoordinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

protocol AppCoordinator: Coodinator {
    func showHomeFlow()
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
    }
    
    deinit {
        debugPrint("deinit: \(self)")
    }
    
    func start() {
        setHomeCoordinator()
        showHomeFlow()
    }
    
    // 탭바 플로우
    func showHomeFlow() {
        if getChildCoordinator(.tabBar) == nil { setHomeCoordinator() }
        let tabBarCoordinator = getChildCoordinator(.tabBar) as! TabBarCoordinator
        tabBarCoordinator.finishDelegate = self
        tabBarCoordinator.start()
    }
    
    // 로그인 플로우
    func showLoginFlow() {
        
    }
    
    func setHomeCoordinator() {
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

