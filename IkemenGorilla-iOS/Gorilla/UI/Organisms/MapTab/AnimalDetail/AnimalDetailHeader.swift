//
//  AnimalDetailHeader.swift
//  Gorilla
//
//  Created by admin on 2020/06/25.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

final class AnimalDetailHeader: UIView, View, ViewConstructor {
    
    struct Const {
        static let imageViewSize: CGFloat = 112
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Const.imageViewSize / 2
    }
    
    private let animalNameLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 24)
        $0.textColor = Color.textBlack
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private let fanNumberLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 15)
        $0.textColor = Color.textBlack
    }
    
    private let fanLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 12)
        $0.textColor = Color.textGray
        $0.text = "fan"
    }
    
    private let zooNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 15)
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
        addSubview(imageView)
        addSubview(animalNameLabel)
        addSubview(fanNumberLabel)
        addSubview(fanLabel)
        addSubview(zooNameLabel)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.imageViewSize)
        }
        animalNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
        }
        fanNumberLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.centerY)
            $0.left.equalTo(imageView.snp.right).offset(16)
        }
        fanLabel.snp.makeConstraints {
            $0.left.equalTo(fanNumberLabel.snp.right).offset(8)
            $0.bottom.equalTo(fanNumberLabel)
        }
        zooNameLabel.snp.makeConstraints {
            $0.top.equalTo(fanNumberLabel.snp.bottom).offset(8)
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: AnimalDetailReactor) {
        // Action
        
        // State
        reactor.state.map { $0.animal.iconUrl }
            .distinctUntilChanged()
            .bind { [weak self] iconUrl in
                self?.imageView.setImage(imageUrl: iconUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.animal.name }
            .distinctUntilChanged()
            .bind(to: animalNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.animal.numberOfFans }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: fanNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.zooName }
            .distinctUntilChanged()
            .bind(to: zooNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
