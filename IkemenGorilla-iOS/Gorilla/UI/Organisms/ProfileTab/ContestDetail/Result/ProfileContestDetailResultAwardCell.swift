//
//  ProfileContestDetailResultAwardCell.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ProfileContestDetailResultAwardCell: UICollectionViewCell, View, ViewConstructor {
    
    struct Const {
        static let cellWidth: CGFloat = (DeviceSize.screenWidth - 48) / 2
        static let cellHeight: CGFloat = cellWidth + 8 + 16 + 16 + 24 + 56
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Const.cellWidth / 2
    }
    
    private let animalNameLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 16)
        $0.textColor = Color.textGray
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private let awardNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.textColor = Color.textBlack
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
    }
    
    private let border = UIView().then {
        $0.backgroundColor = Color.textBlack
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
        addSubview(awardNameLabel)
        addSubview(border)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.size.equalTo(Const.cellWidth)
        }
        animalNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(8)
            $0.height.equalTo(16)
        }
        awardNameLabel.snp.makeConstraints {
            $0.top.equalTo(animalNameLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(8)
            $0.height.equalTo(24)
            $0.bottom.equalToSuperview().inset(56)
        }
        border.snp.makeConstraints {
            $0.top.equalTo(awardNameLabel.snp.bottom).offset(4)
            $0.right.left.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ProfileContestDetailResultAwardCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.award.iconUrl }
            .distinctUntilChanged()
            .bind { [weak self] iconUrl in
                self?.imageView.setImage(imageUrl: iconUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.award.animalName }
            .distinctUntilChanged()
            .bind(to: animalNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.award.awardName }
            .distinctUntilChanged()
            .bind(to: awardNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
