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
    
    private let textField = UITextField().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Color.borderGray.cgColor
        $0.placeholder = "input your words ..."
    }
    
    private let button = UIButton().then {
        $0.setTitle("Send", for: .normal)
        $0.titleLabel?.apply(fontStyle: .bold, size: 20)
        $0.setTitleColor(Color.teal, for: .normal)
        $0.setTitleColor(Color.gray, for: .highlighted)
    }
    
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
        view.addSubview(textField)
        view.addSubview(button)
    }
    
    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(240)
            $0.centerX.equalToSuperview()
        }
        echoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(echoLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(32)
        }
        button.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom).offset(24)
            $0.height.equalTo(32)
            $0.width.equalTo(80)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: FrontendEchoReactor) {
        // Action
        textField.rx.text
            .bind { text in
                reactor.action.onNext(.updateSendText(text ?? ""))
            }
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind { _ in
                reactor.action.onNext(.send)
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.returnText }
            .distinctUntilChanged()
            .bind(to: echoLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}
