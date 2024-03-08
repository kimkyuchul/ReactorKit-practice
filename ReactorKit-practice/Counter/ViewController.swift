//
//  ViewController.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 2/4/24.
//

import UIKit

import RxCocoa
import RxSwift
import ReactorKit

final class ViewController: UIViewController, View {
    
    weak var coordinator: HomeCoodinator?
    var disposeBag = DisposeBag()
    
    private let countLabel: UILabel = {
        let countLabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.text = "0"
        countLabel.textAlignment = .center
        return countLabel
    }()
    private let increaseButton: UIButton = {
        let increaseButton = UIButton()
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.setTitle("Increase", for: .normal)
        return increaseButton
    }()
    private let pushButton: UIButton = {
        let pushButton = UIButton()
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.setTitle("gogogo", for: .normal)
        return pushButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        self.reactor = ViewReactor()
        setLayout()
//        bind(reactor: ViewReactor())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(coordinator?.childCoodinators.count)
    }
    
    // Reactor에 View의 Action을 미리 정의해놓고, 해당 action을 처리하여 다시 View에 State값을 넘기는 것
    // View에서는 인터렉터 이벤트들을 Reactor의 Action값으로 넘기고, reactor의 state값을 구독하고 UI업데이트 하는 것
    func bind(reactor: ViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ViewReactor) {
        let tap = increaseButton.rx.tap
            .share()
        
        tap
            .bind { _ in
                dump("tap")
            }
            .disposed(by: disposeBag)
        
        tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pushButton.rx.tap
            .asSignal()
            .emit(with: self) { owner, _ in
                owner.coordinator?.showSecond()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ViewReactor) {
        reactor.state
            .map { String($0.value) }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setLayout() {
        view.addSubview(countLabel)
        view.addSubview(increaseButton)
        view.addSubview(pushButton)
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            increaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            increaseButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 20),
            
            pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushButton.topAnchor.constraint(equalTo: increaseButton.bottomAnchor, constant: 20)
        ])
    }
}

