//
//  FrontendEchoViewController.swift
//  Gorilla
//
//  Created by admin on 2020/05/26.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class FrontendEchoViewController: UIViewController, ViewConstructor {
    private let titleLabel = UILabel().then {
            $0.text = "FrontendEcho ViewController"
        }
        
        private let echoLabel = UILabel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupViews()
            setupViewConstraints()
        }
        
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
    }
