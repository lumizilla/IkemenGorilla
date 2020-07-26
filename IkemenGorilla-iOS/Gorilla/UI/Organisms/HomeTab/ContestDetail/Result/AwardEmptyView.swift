//
//  AwardEmptyView.swift
//  Gorilla
//
//  Created by admin on 2020/07/27.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class AwardEmptyView: UIView, ViewConstructor {
    
    struct Const {
        static let height: CGFloat = 160
    }
    
    let emptyImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = #imageLiteral(resourceName: "empty_state")
    }
    
    let emptyLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 16)
        $0.textColor = Color.textGray
        $0.text = "まだコンテストが終了していません"
        $0.numberOfLines = 0
        $0.textAlignment = .center
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
        addSubview(emptyImageView)
        addSubview(emptyLabel)
    }
    
    func setupViewConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(Const.height)
            $0.width.equalTo(DeviceSize.screenWidth)
        }
        emptyImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(36)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
        emptyLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(36)
            $0.top.equalTo(emptyImageView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
    }
}
