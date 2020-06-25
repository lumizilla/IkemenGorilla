//
//  ProfileInfoHeader.swift
//  Gorilla
//
//  Created by admin on 2020/06/07.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class ProfileInfoHeader: UIView, ViewConstructor {
    private struct Const {
        static let height: CGFloat = 50
    }
    
    // MARK: - Variables
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: Const.height)
    }
    
    // MARK: - Views
    private let label = UILabel().then {
        $0.apply(fontStyle: .black, size: 16)
        $0.textColor = Color.textBlack
        $0.text = "プロフィール"
    }
    
    private let space = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.text = ""
    }
    
    private let border = UIView().then {
        $0.backgroundColor = Color.borderGray
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
        addSubview(space)
        addSubview(border)
    }
    
    func setupViewConstraints() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        space.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
        }
        border.snp.makeConstraints {
            $0.top.equalTo(space.snp.bottom).inset(1)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
