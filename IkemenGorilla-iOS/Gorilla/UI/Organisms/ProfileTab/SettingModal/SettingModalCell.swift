//
//  SettingModalCell.swift
//  Gorilla
//
//  Created by admin on 2020/07/09.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SettingModalCell: UIButton, ViewConstructor {
    
    enum CellType {
        case postmanAPI
        case herokuAPI
        
        func text() -> String {
            switch self {
            case .postmanAPI:
                return "Postman mock api"
            case .herokuAPI:
                return "Heroku api"
            }
        }
        
        func icon() -> UIImage {
            switch self {
            case .postmanAPI:
                return #imageLiteral(resourceName: "heart_filled").withRenderingMode(.alwaysTemplate)
            case .herokuAPI:
                return #imageLiteral(resourceName: "heart_filled").withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    let type: CellType
    
    let iconView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = Color.textBlack
    }
    
    let textLabel = UILabel(textStyle: .normalBold).then {
        $0.textColor = Color.textBlack
    }
    
    let border = UIView().then {
        $0.backgroundColor = Color.borderGray
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? Color.lightGray : Color.white
        }
    }
    
    init(type: CellType) {
        self.type = type
        super.init(frame: .zero)
        
        iconView.image = type.icon()
        textLabel.text = type.text()
        
        setupViews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(iconView)
        addSubview(textLabel)
        addSubview(border)
    }
    
    func setupViewConstraints() {
        iconView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        textLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(16)
            $0.centerY.equalTo(iconView)
        }
        border.snp.makeConstraints {
            $0.left.equalTo(textLabel)
            $0.bottom.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
