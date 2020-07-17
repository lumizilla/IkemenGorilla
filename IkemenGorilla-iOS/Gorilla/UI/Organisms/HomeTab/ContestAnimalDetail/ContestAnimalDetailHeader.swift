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

protocol ContestAnimalDetailHeaderDelegate {
    func didTapZoo() -> Void
}

final class ContestAnimalDetailHeader: UIView, View, ViewConstructor {
    struct Const {
        static let imageViewHeight: CGFloat = DeviceSize.screenWidth + 88
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: Const.imageViewHeight )
    }
    
    var delegate: ContestAnimalDetailHeaderDelegate?
    
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
    
    private let zooNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 15)
        $0.textColor = Color.textBlack
    }
    
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
    
    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 13)
        $0.textColor = Color.textGray
        $0.numberOfLines = 0
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
        addSubview(zooNameLabel)
        addSubview(mapIconView)
        addSubview(addressLabel)
        addSubview(descriptionLabel)
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
        zooNameLabel.snp.makeConstraints {
            $0.top.equalTo(underlay.snp.bottom)
            $0.left.equalToSuperview().inset(16)
        }
        mapIconView.snp.makeConstraints {
            $0.top.equalTo(zooNameLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(16)
        }
        addressLabel.snp.makeConstraints {
            $0.centerY.equalTo(mapIconView)
            $0.left.equalTo(mapIconView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(mapIconView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestAnimalDetailReactor) {
        // Action
        voteButton.rx.tap
            .bind { _ in
                reactor.action.onNext(.tapVoteButton)
            }
            .disposed(by: disposeBag)
        
        zooNameLabel.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.delegate?.didTapZoo()
            }
            .disposed(by: disposeBag)
        
        mapIconView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.delegate?.didTapZoo()
            }
            .disposed(by: disposeBag)
        
        addressLabel.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.delegate?.didTapZoo()
            }
            .disposed(by: disposeBag)
        
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
        
        reactor.state.map { $0.response?.zooName }
            .distinctUntilChanged()
            .bind(to: zooNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.response?.zooAddress }
            .distinctUntilChanged()
            .bind(to: addressLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.response?.description }
            .distinctUntilChanged()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isVoted }
            .distinctUntilChanged()
            .bind(to: voteButton.rx.isVoted)
            .disposed(by: disposeBag)
    }
}
