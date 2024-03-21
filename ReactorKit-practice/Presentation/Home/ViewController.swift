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
    private let decreaseButton: UIButton = {
        let increaseButton = UIButton()
        increaseButton.translatesAutoresizingMaskIntoConstraints = false
        increaseButton.setTitle("Decrease", for: .normal)
        return increaseButton
    }()
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tintColor = .systemPink
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    private let pushButton: UIButton = {
        let pushButton = UIButton()
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.setTitle("gogogo", for: .normal)
        return pushButton
    }()
    private let justNavPushButton: UIButton = {
        let pushButton = UIButton()
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.setTitle("justNavPush", for: .normal)
        return pushButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        setLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.printStack()
    }
    
    // Reactor에 View의 Action을 미리 정의해놓고, 해당 action을 처리하여 다시 View에 State값을 넘기는 것
    // View에서는 인터렉터 이벤트들을 Reactor의 Action값으로 넘기고, reactor의 state값을 구독하고 UI업데이트 하는 것
    func bind(reactor: ViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ViewReactor) {
        increaseButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pushButton.rx.tap
            .asSignal()
            .emit(with: self) { owner, _ in
                owner.coordinator?.showSecond(productId: 1)
            }
            .disposed(by: disposeBag)
        
        justNavPushButton.rx.tap
            .asSignal()
            .emit(with: self) { owner, _ in
                owner.coordinator?.pushThirdView(argument: 1231)
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
        
        reactor.state
            .map { $0.isLoading }
            .debug() // Event next(true) 2번, Event next(false) 2번 발생
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(indicatorView.rx.isAnimating, indicatorView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // 위에서 State 이벤트는 값이 변하든 안 변하든 상관없이, 이벤트가 항상 오는 것을 확인
        // 하지만 Pulse property wrapper를 사용하면 값이 새롭게 할당(assign) 되는 상황에만 이벤트가 발생한다는 것
        // State 이벤트 받을 때 distinctUntilChanged를 사용 안 하면 Pulse property wrapper랑 똑같이 동작 => X
        // distinctUntilChanged를 사용하지 않았을 때 State의 특정 프로퍼티가 값이 변하거나 새로 할당될 때만 이벤트가 오는 것이 아니다. 다른 프로퍼티의 값이 바뀌게 되는 경우에도 이벤트가 오기 때문
        //  Pulse property wrapper를 사용하게 되면, 특정 프로퍼티에 값이 새로 할당되는 경우에만 이벤트가 발생하기 때문에, 다른 프로퍼티 값이 바뀌어도 이벤트가 오지 않는 것
        reactor.pulse(\.$alertMessage)
            .debug()
            .bind(with: self) { owner, message in
                let alertController = UIAlertController(
                       title: nil,
                       message: message,
                       preferredStyle: .alert
                   )
                   alertController.addAction(UIAlertAction(
                       title: "OK",
                       style: .default,
                       handler: nil
                   ))
                owner.present(alertController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setLayout() {
        view.addSubview(countLabel)
        view.addSubview(increaseButton)
        view.addSubview(decreaseButton)
        view.addSubview(indicatorView)
        view.addSubview(pushButton)
        view.addSubview(justNavPushButton)
        
        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            increaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            increaseButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 20),
            
            decreaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            decreaseButton.topAnchor.constraint(equalTo: increaseButton.bottomAnchor, constant: 20),
            
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pushButton.topAnchor.constraint(equalTo: decreaseButton.bottomAnchor, constant: 20),
            
            justNavPushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            justNavPushButton.topAnchor.constraint(equalTo: pushButton.bottomAnchor, constant: 20)
            
        ])
    }
}

