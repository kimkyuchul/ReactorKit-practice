//
//  SecondViewController.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/8/24.
//

import UIKit

import RxCocoa
import RxSwift

final class SecondViewController: UIViewController {
    
    weak var coordinator: SecondViewCoodinator?
    private let viewModel: SecondViewModel
    private let disposeBag = DisposeBag()
    
    private let dismissButton: UIButton = {
        let pushButton = UIButton()
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.setTitle("dismissButtondismissButton", for: .normal)
        return pushButton
    }()
    
    init(viewModel: SecondViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setLayout()
        
        dismissButton.rx.tap.asSignal()
            .emit(with: self) { owner, _ in
                owner.coordinator?.didFinish()
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(coordinator?.productId)
    }
    
    func setLayout() {
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
