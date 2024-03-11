//
//  SearchViewController.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import UIKit

import RxCocoa
import RxSwift
import ReactorKit

final class SearchViewController: UIViewController, View {
    
    weak var coordinator: SearchCoordinator?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
    }
    
    func bind(reactor: SearchViewReactor) {
        
    }
}
