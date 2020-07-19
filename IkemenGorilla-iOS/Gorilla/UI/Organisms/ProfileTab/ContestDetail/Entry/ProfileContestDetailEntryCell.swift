//
//  ProfileContestDetailEntryCell.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ProfileContestDetailEntryCell: UICollectionViewCell, View, ViewConstructor {
    
    struct Const {
        static let cellWidth: CGFloat = (DeviceSize.screenWidth - 48) / 2
        static let cellHeight: CGFloat = cellWidth * 200 / 164
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let animalNameLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 16)
        $0.textColor = Color.white
    }
    
    private let zooNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 10)
        $0.textColor = Color.white
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
        layer.masksToBounds = true
        layer.cornerRadius = 4
        addSubview(imageView)
        addSubview(animalNameLabel)
        addSubview(zooNameLabel)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        animalNameLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(8)
            $0.bottom.equalTo(zooNameLabel.snp.top).offset(-8)
        }
        zooNameLabel.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ProfileContestDetailEntryCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.entry.iconUrl }
            .distinctUntilChanged()
            .bind { [weak self] iconUrl in
                self?.imageView.setImage(imageUrl: iconUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.entry.name }
            .distinctUntilChanged()
            .bind(to: animalNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.entry.zooName }
            .distinctUntilChanged()
            .bind(to: zooNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

