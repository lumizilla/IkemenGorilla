//
//  HomeCurrentContestHeader.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class HomeCurrentContestHeader: UIView, ViewConstructor {
    private let label = UILabel().then {
        $0.apply(fontStyle: .medium, size: 27)
        $0.textColor = Color.textBlack
        $0.text = "開催中のコンテスト"
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(label)
    }
    
    func setupViewConstraints() {
        label.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(24)
        }
    }
}
