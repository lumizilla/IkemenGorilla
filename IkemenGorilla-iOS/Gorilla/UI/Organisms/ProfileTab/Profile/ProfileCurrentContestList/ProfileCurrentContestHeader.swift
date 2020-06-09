//
//  ProfileCurrentContestHeader.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class ProfileCurrentContestHeader: UIView, ViewConstructor {
    private let label = UILabel().then {
        $0.apply(fontStyle: .medium, size: 27)
        $0.textColor = Color.textBlack
        $0.text = "開催中のコンテスト"
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: 64)
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
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(24)
        }
    }
}
