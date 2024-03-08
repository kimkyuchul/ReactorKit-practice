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
    private let disposeBag = DisposeBag()
    
    private let dismissButton: UIButton = {
        let pushButton = UIButton()
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.setTitle("dismissButtondismissButton", for: .normal)
        return pushButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setLayout()
        
        dismissButton.rx.tap.asSignal()
            .emit(with: self) { owner, _ in
//                owner.coordinator?.finish()
//                owner.navigationController?.dismiss(animated: false)
                owner.coordinator?.didFinish()
            }
            .disposed(by: disposeBag)
    }
    
    func setLayout() {
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
