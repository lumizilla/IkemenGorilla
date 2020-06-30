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
        static let height: CGFloat = imageViewHeight + 24 + 24 + 12 + 20 + 24
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: Const.height)
    }
    
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
    
    private let heartButton = HeartButton()
    
    private let zooNameLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 24)
        $0.textColor = Color.textBlack
    }
    
    private let heartNumberView = HeartNumberView()
    
    private let mapIconView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "map_empty").withRenderingMode(.alwaysTemplate)
        $0.tintColor = Color.textBlack
        $0.contentMode = .scaleAspectFit
    }
    
    private let addressLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textBlack
        $0.adjustsFontSizeToFitWidth = true
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
        addSubview(heartButton)
        addSubview(zooNameLabel)
        addSubview(heartNumberView)
        addSubview(mapIconView)
        addSubview(addressLabel)
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
        heartButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(32)
            $0.size.equalTo(64)
            $0.bottom.equalTo(imageView)
        }
        zooNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        heartNumberView.snp.makeConstraints {
            $0.centerY.equalTo(zooNameLabel)
            $0.right.equalToSuperview().inset(16)
        }
        mapIconView.snp.makeConstraints {
            $0.top.equalTo(zooNameLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(20)
            $0.bottom.equalToSuperview().inset(24)
        }
        addressLabel.snp.makeConstraints {
            $0.centerY.equalTo(mapIconView)
            $0.left.equalTo(mapIconView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ZooDetailReactor) {
        // Action
        heartButton.rx.tap
            .bind { _ in
                reactor.action.onNext(.tapHeartButton)
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.zoo.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.zooDetail?.isFavorite ?? true }
            .distinctUntilChanged()
            .bind(to: heartButton.rx.isSelected)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.zoo.name }
            .distinctUntilChanged()
            .bind(to: zooNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.zooDetail?.numberOfFavorites ?? 0 }
            .distinctUntilChanged()
            .map { numberOfFans in "\(numberOfFans)" }
            .bind(to: heartNumberView.numberLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.zoo.address }
            .distinctUntilChanged()
            .bind(to: addressLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
