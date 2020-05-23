//
//  DevelopingViewController.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SnapKit
import Then

final class DevelopingViewController: UIViewController, ViewConstructor {
    
    private let titleLabel = UILabel().then {
        $0.text = "Developing ViewController"
    }
    
    private let typeLabel = UILabel()
    
    init(type: String) {
        super.init(nibName: nil, bundle: nil)
        
        typeLabel.text = type
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(typeLabel)
    }
    
    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        typeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
    }
}
