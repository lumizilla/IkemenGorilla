//
//  ProfileVotedContestHeader.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class ProfileVotedContestHeader: UIView, ViewConstructor {
    private struct Const {
        static let height: CGFloat = 56
    }
    
    // MARK: - Variables
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: Const.height)
    }
    
    // MARK: - Views
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 20)
        $0.textColor = Color.textBlack
        $0.text = "投票したコンテスト"
    }
    
    let showAllButton = UIButton().then {
        $0.titleLabel?.apply(fontStyle: .regular, size: 16)
        $0.setTitle("すべて見る", for: .normal)
        $0.setTitleColor(Color.textBlack, for: .normal)
        $0.setTitleColor(Color.lightGray, for: .highlighted)
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        addSubview(titleLabel)
        addSubview(showAllButton)
    }
    
    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
        showAllButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
}
