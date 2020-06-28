//
//  MapSearchButton.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class MapSearchButton: UIButton, ViewConstructor {
    
    struct Const {
        static let height: CGFloat = 44
        static let width: CGFloat = DeviceSize.screenWidth - 48
    }
    
    // MARK: - Variables
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    // MARK: - Views
    private let searchIconView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = #imageLiteral(resourceName: "search_empty").withRenderingMode(.alwaysTemplate)
        $0.tintColor = Color.textBlack
    }
    
    private let placeHolderLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 15)
        $0.textColor = Color.textBlack
        $0.text = "動物園、住所"
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
        backgroundColor = Color.white
        layer.cornerRadius = Const.height / 2
        addSubview(searchIconView)
        addSubview(placeHolderLabel)
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = Color.black.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
    }
    
    func setupViewConstraints() {
        snp.makeConstraints {
            $0.width.equalTo(Const.width)
            $0.height.equalTo(Const.height)
        }
        searchIconView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
            $0.right.equalTo(placeHolderLabel.snp.left).offset(-8)
        }
        placeHolderLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(14)
        }
    }
    
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: [.allowUserInteraction],
                       animations: {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.transform = .identity
            }
        },
        completion: nil)
    }
}
