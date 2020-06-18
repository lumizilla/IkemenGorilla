//
//  ZooDetailHeader.swift
//  Gorilla
//
//  Created by admin on 2020/06/18.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ZooDetailHeader: UIView, View, ViewConstructor {
    struct Const {
        static let imageViewHeight: CGFloat = DeviceSize.screenWidth * 312 / 375
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }
    
    private let overlay = UIView().then {
        $0.backgroundColor = Color.white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 32
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
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
        addSubview(imageView)
        addSubview(overlay)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.imageViewHeight)
        }
        overlay.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(64)
            $0.bottom.equalTo(imageView).offset(32)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ZooDetailReactor) {
        // Action
        
        // State
        reactor.state.map { $0.zoo.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
    }
}
