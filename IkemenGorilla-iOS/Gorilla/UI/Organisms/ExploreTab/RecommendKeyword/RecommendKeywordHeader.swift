//
//  RecommendKeywordHeader.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class RecommendKeywordHeader: UIView, ViewConstructor {
    struct Const {
        static let height: CGFloat = 48
    }
    
    // MARK: - Views
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 15)
        $0.textColor = Color.textBlack
        $0.text = "おすすめの検索ワード"
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
    }
    
    func setupViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        snp.makeConstraints {
            $0.height.equalTo(Const.height)
        }
    }
}
