//
//  MapZooCell.swift
//  Gorilla
//
//  Created by admin on 2020/06/18.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class MapZooCell: UICollectionViewCell, View, ViewConstructor {
    struct Const {
        static let imageViewHeight: CGFloat = (DeviceSize.screenWidth - 64) * 200 / 311
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let zooNameLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 16)
        $0.textColor = Color.textBlack
    }
    
    // MARK: Initializers
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
        addSubview(zooNameLabel)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.imageViewHeight)
        }
        zooNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: MapZooCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.zoo.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.zoo.name }
            .distinctUntilChanged()
            .bind(to: zooNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
