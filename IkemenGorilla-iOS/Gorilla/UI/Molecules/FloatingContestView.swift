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
        $0.textColor = Color.textGray
        $0.numberOfLines = 0
    }
    
    let durationLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 10)
        $0.textColor = Color.textGray
    }
    
    let votedLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 13)
        $0.textColor = Color.textGray
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
        addSubview(durationLabel)
        addSubview(votedLabel)
        
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
        durationLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(votedLabel.snp.top).offset(-8)
        }
        votedLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.bottom.equalToSuperview().inset(16)
        }
    }
}
