//
//  LoginViewController.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import UIKit

import RxCocoa
import RxSwift
import ReactorKit

final class LoginViewController: UIViewController, View {
    
    weak var coordinator: LoginCoordinator?
    var disposeBag = DisposeBag()
    
    private let homeButton: UIButton = {
        let increaseButton = UIButton()
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.setTitle("home", for: .normal)
        return increaseButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        setLayout()
        
        homeButton.rx.tap
            .asSignal()
            .emit(with: self) { owner, _ in
                owner.coordinator?.gotoMain()
            }
            .disposed(by: disposeBag)
    }
    
    func bind(reactor: LoginViewReactor) {
    }
    
    
    func setLayout() {
        view.addSubview(homeButton)
        
        NSLayoutConstraint.activate([
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
        
    }
}


