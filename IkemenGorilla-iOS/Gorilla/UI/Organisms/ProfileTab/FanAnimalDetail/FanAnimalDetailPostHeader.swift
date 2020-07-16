//
//  FanAnimalDetailPostHeader.swift
//  Gorilla
//
//  Created by admin on 2020/07/09.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class FanAnimalDetailPostHeader: UIView, ViewConstructor {
    // MARK: - Views
    private let postsHeader = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.textColor = Color.black
        $0.text = "投稿"
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
        addSubview(postsHeader)
    }
    
    func setupViewConstraints() {
        postsHeader.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.width.equalTo(DeviceSize.screenWidth - 32)
            $0.bottom.equalToSuperview()
        }
    }
}
