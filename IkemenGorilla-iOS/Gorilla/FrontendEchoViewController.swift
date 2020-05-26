//
//  FrontendEchoViewController.swift
//  Gorilla
//
//  Created by admin on 2020/05/26.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class FrontendEchoViewController: UIViewController, View, ViewConstructor {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let titleLabel = UILabel().then {
            $0.text = "FrontendEcho ViewController"
    }
            
    private let echoLabel = UILabel()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(echoLabel)
    }
    
    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        echoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: FrontendEchoReactor) {
        // Action
        
        // State
        reactor.state.map { $0.echo }
            .distinctUntilChanged()
            .bind(to: echoLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
