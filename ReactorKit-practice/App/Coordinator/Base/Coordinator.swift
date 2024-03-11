//
//  Coordinator.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

enum CoordinatorType {
    case app, tabBar
    case home, second
    case search
}

protocol Coodinator: AnyObject {
    // 자식 코디네이터를 저장하기 위한 배열
    var childCoodinators: [Coodinator] { get set }
    // 네비게이션 스택을 쌓을 UINavigationController 타입 변수
    var navigationController: UINavigationController { get set }
    
    var type: CoordinatorType { get }
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    
    func finish()
}

extension Coodinator {
    // 용자가 앱 내에서 특정 작업 시퀀스를 완료했을 때 (예: 회원가입, 주문 완료, 튜토리얼 완료 등) 해당 흐름을 관리하는 코디네이터가 finish() 메서드를 호출하여 자신이 완료되었음을 부모 코디네이터에게 알린다.
    // 화면 전환: 사용자가 어떤 작업을 완료하고 새로운 화면 또는 기능으로 넘어갈 때, 현재 화면을 관리하는 코디네이터가 finish()를 호출함으로써, 자신의 작업이 끝났다는 것을 상위 코디네이터에게 알리고, 자식 코디네이터 목록에서 자신을 제거
    // 모달 또는 팝업의 닫힘: 모달 창이나 팝업 같은 임시 뷰가 닫힐 때, 이를 관리하는 코디네이터가 finish() 메서드를 사용하여 종료 처리를 하고, 필요한 정리 작업을 수행
    // 뒤로 가기 또는 취소: 사용자가 뒤로 가기 버튼을 누르거나 취소를 선택하여 현재 진행 중인 흐름을 종료하려고 할 때, 해당 흐름을 관리하는 코디네이터가 finish()를 호출하여 작업을 종료
    func finish() {
        // 현재 코디네이터가 관리하는 모든 자식 코디네이터의 참조를 제거하는 작업
        childCoodinators.removeAll()
        // 현재 코디네이터(self)가 작업을 완료했다는 것을 부모 코디네이터에게 알리는 과정
        // 부모 코디네이터로 하여금 현재 코디네이터를 자신의 childCoordinators 배열에서 제거할 수 있게 한다.
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

// 자식 코디네이터가 종료되었을 때 실행할 메서드
extension Coodinator where Self: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coodinator) {
        childCoodinators = childCoodinators.filter { $0.type != childCoordinator.type }
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coodinator)
}


