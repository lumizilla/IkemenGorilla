//
//  RecommendedZooCell.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class HomeRecommendedZooCell: UICollectionViewCell, View, ViewConstructor {
    
    struct Const {
        static let cellWidth: CGFloat = DeviceSize.screenWidth
        static let cellHeight: CGFloat = 120
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
        static let imageViewSize: CGFloat = 104
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
    }
    private let zooNameLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 16)
        $0.textColor = Color.black
        $0.numberOfLines = 0
    }
    private let recommendLabel = UILabel().then {
        $0.text = "おすすめ"
        $0.apply(fontStyle: .regular, size: 15)
        $0.textColor = Color.textGray
    }
    private let border = UIView().then {
        $0.backgroundColor = Color.borderGray
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
        addSubview(zooNameLabel)
        addSubview(recommendLabel)
        addSubview(border)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.imageViewSize)
        }
        zooNameLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.snp.centerY)
        }
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.centerY)
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
        }
        border.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: HomeRecommendedZooCellReactor) {
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
