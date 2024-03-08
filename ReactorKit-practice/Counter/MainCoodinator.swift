//
//  MainCoodinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

protocol Coodinator: AnyObject {
    // 자식 코디네이터를 저장하기 위한 배열
    var childCoodinators: [Coodinator] { get set }
    // 네비게이션 스택을 쌓을 UINavigationController 타입 변수
    var navigationController: UINavigationController { get set }
    
    func start()
}

class MainCoodinator: Coodinator {
    var childCoodinators: [Coodinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // start 메서드를 통해 MainView를 띄운다.
    func start() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushSecond() {
        let secondCoodinator = SecondViewCoodinator(navigationController: navigationController)
        // 메모리에서 해제되지 않도록 childCoodinators에 append
        childCoodinators.append(secondCoodinator)
        secondCoodinator.start()
    }
}
