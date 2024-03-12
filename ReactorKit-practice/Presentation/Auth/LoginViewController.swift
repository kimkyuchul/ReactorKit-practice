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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
    }
    
    func bind(reactor: LoginViewReactor) {
        
    }
}


