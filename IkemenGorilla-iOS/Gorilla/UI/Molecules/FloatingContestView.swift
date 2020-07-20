//
//  FloatingContestView.swift
//  Gorilla
//
//  Created by admin on 2020/06/25.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class FloatingContestView: UIView, ViewConstructor {
    
    
    // MARK: - Views
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let sheet = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    let contestNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 15)
        $0.textColor = Color.textBlack
        $0.numberOfLines = 0
    }
    
    let catchCopyLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 14)
        $0.textColor = Color.textGray
    }
    
    let durationLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 13)
        $0.textColor = Color.textGray
    }
    
    let emptyLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 16)
        $0.textColor = Color.textBlack
        $0.text = "現在参加しているコンテストはありません"
        $0.numberOfLines = 0
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
        addSubview(sheet)
        addSubview(imageView)
        addSubview(contestNameLabel)
        addSubview(catchCopyLabel)
        addSubview(durationLabel)
        addSubview(emptyLabel)
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = Color.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.size.equalTo(160)
        }
        sheet.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.right.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).offset(-16)
        }
        contestNameLabel.snp.makeConstraints {
            $0.top.right.equalTo(sheet).inset(16)
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
        catchCopyLabel.snp.makeConstraints {
            $0.top.equalTo(contestNameLabel.snp.bottom).offset(8)
            $0.right.equalTo(sheet).inset(16)
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
        durationLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalTo(sheet).inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        emptyLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalTo(sheet).inset(16)
            $0.centerY.equalTo(sheet)
        }
    }
}
