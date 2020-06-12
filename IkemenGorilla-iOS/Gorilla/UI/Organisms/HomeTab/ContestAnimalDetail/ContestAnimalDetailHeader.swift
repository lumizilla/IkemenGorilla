//
//  ContestAnimalDetailHeader.swift
//  Gorilla
//
//  Created by admin on 2020/06/12.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ContestAnimalDetailHeader: UIView, View, ViewConstructor {
    struct Const {
        static let imageViewHeight: CGFloat = DeviceSize.screenWidth + 88
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: Const.imageViewHeight )
    }
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
    }
    
    private let underlay = UIView().then {
        $0.backgroundColor = Color.white
        $0.layer.masksToBounds = true
    }
    
    private let animalNameLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 24)
        $0.textColor = Color.textBlack
    }
    
    private let voteButton = VoteButton()
    
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
        addSubview(underlay)
        addSubview(animalNameLabel)
        addSubview(voteButton)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.imageViewHeight)
        }
        underlay.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(imageView)
            $0.height.equalTo(88)
        }
        animalNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(16)
            $0.centerY.equalTo(underlay)
        }
        voteButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.centerY.equalTo(underlay)
            $0.width.equalTo(96)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestAnimalDetailReactor) {
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
    }
}
