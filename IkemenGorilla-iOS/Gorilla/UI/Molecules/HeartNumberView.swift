//
//  HeartNumberView.swift
//  Gorilla
//
//  Created by admin on 2020/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class HeartNumberView: UIView, ViewConstructor {
    // MARK: - Views
    private let heartIconView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "heart_empty").withRenderingMode(.alwaysTemplate)
        $0.tintColor = Color.red
        $0.contentMode = .scaleAspectFill
    }
    
    let numberLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 12)
        $0.textColor = Color.red
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
        backgroundColor = Color.red.withAlphaComponent(0.1)
        addSubview(heartIconView)
        addSubview(numberLabel)
        
        layer.masksToBounds = true
        layer.cornerRadius = 4
    }
    
    func setupViewConstraints() {
        heartIconView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(8)
            $0.size.equalTo(16)
        }
        numberLabel.snp.makeConstraints {
            $0.centerY.equalTo(heartIconView)
            $0.left.equalTo(heartIconView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(8)
        }
    }
}
