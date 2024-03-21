//
//  ThirdViewController.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

import RxCocoa
import RxSwift

final class ThirdViewController: UIViewController {
    
    weak var coordinator: HomeCoodinator?
    private let viewModel: ThirdViewModel
    private let disposeBag = DisposeBag()
    
    private let dismissButton: UIButton = {
        let pushButton = UIButton()
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.setTitle("dismissButtondismissButton", for: .normal)
        return pushButton
    }()
    private let goLoginButton: UIButton = {
        let pushButton = UIButton()
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.setTitle("goLoginButton", for: .normal)
        return pushButton
    }()
    
    
    init(viewModel: ThirdViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ThirdViewController deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        setLayout()
        
        dismissButton.rx.tap.asSignal()
            .emit(with: self) { owner, _ in
            }
            .disposed(by: disposeBag)
        
        goLoginButton.rx.tap.asSignal()
            .emit(with: self) { owner, _ in
                owner.coordinator?.pop()
            }
            .disposed(by: disposeBag)
        
        
        print(viewModel.id)
        coordinator?.printStack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setLayout() {
        view.addSubview(dismissButton)
        view.addSubview(goLoginButton)
        
        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            goLoginButton.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 20),
            goLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
