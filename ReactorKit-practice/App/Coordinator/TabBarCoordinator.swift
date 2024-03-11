//
//  TabBarCoordinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

final class TabBarCoordinator: Coodinator {
    struct Dependency {
        let navigationController: UINavigationController
        let injector: Injector
    }

    private let dependency: Dependency
    var childCoodinators: [Coodinator] = []
    var navigationController: UINavigationController
    var tabBarController = UITabBarController()
    var type: CoordinatorType = .tabBar
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    init(dependency: Dependency) {
        self.dependency = dependency
        self.navigationController = dependency.navigationController
    }
    
    func start() {
        let pages = TabBarPage.allCases
        let controller = pages.map {
            self.createTabNavigationController(of: $0)
        }
        self.configureTabbarController(with: controller)
    }
    
    /// 각 탭바에 들어갈 네비게이션 컨트롤러 설정
     private func configureTabbarController(with tabViewControllers: [UIViewController]) {
         self.tabBarController.setViewControllers(tabViewControllers, animated: true)
         self.tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
         self.tabBarController.view.backgroundColor = .white
         self.tabBarController.tabBar.backgroundColor = .white
         self.tabBarController.tabBar.tintColor = .black
         navigationController.viewControllers = [tabBarController]
     }
    
    private func createTabNavigationController(of page: TabBarPage) -> UINavigationController {
        let tabBarNavigationController = UINavigationController()
        tabBarNavigationController.setNavigationBarHidden(false, animated: false)
        tabBarNavigationController.tabBarItem = self.configureTabBarItem(of: page)
        self.setTabBarFlow(of: page, to: tabBarNavigationController)
        return tabBarNavigationController
    }
    
    private func configureTabBarItem(of page: TabBarPage) -> UITabBarItem {
        switch page {
        case .home:
            return UITabBarItem(title: page.rawValue, image: UIImage(named: "xmark"), tag: page.pageOrderNumber())
        case .search:
            return UITabBarItem(title: page.rawValue, image: UIImage(named: "xmark"), tag: page.pageOrderNumber())
        }
    }
    
    private func setTabBarFlow(of page: TabBarPage, to tabNavigationController: UINavigationController) {
        switch page {
        case .home:
            let dependency = HomeCoodinator.Dependency(
                navigationController: tabNavigationController,
                injector: dependency.injector
                )
            let homeCoordinator = HomeCoodinator(dependency: dependency)
            homeCoordinator.finishDelegate = self
            homeCoordinator.start()
            childCoodinators.append(homeCoordinator)
        case .search:
            let dependency = SearchCoordinator.Dependency(
                navigationController: tabNavigationController,
                injector: dependency.injector
            )
            let searchCoordinator = SearchCoordinator(dependency: dependency)
            searchCoordinator.finishDelegate = self
            searchCoordinator.start()
            childCoodinators.append(searchCoordinator)
        }
    }
}

extension TabBarCoordinator: CoordinatorFinishDelegate {}

enum TabBarPage: String, CaseIterable {
    case home, search
    
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .search
        default: return nil
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .home: return 0
        case .search: return 1
        }
    }
    
    func tabIconName() -> String {
        return self.rawValue
    }
}
