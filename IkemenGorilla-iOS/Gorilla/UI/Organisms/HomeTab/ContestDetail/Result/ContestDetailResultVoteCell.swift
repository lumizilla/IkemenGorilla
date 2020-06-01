//
//  ContestDetailResultVoteCell.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ContestDetailResultVoteCell: UICollectionViewCell, View, ViewConstructor {
    
    struct Const {
        static let iconViewSize: CGFloat = 96
        static let indicatorWidth: CGFloat = DeviceSize.screenWidth - 144
        static let cellWidth: CGFloat = DeviceSize.screenWidth
        static let cellHeight: CGFloat = 112
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let iconView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Const.iconViewSize / 2
    }
    
    private let animalNameLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15)
        $0.textColor = Color.black
    }
    
    private let numberOfVotesLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 15)
        $0.textColor = Color.textGray
    }
    
    private let votesIndicatorBackView = UIView().then {
        $0.backgroundColor = Color.borderGray
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    private let votesIndicatorFrontView = UIView().then {
        $0.backgroundColor = Color.teal
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
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
        addSubview(iconView)
        addSubview(animalNameLabel)
        addSubview(numberOfVotesLabel)
        addSubview(votesIndicatorBackView)
        addSubview(votesIndicatorFrontView)
    }
    
    func setupViewConstraints() {
        iconView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.iconViewSize)
        }
        animalNameLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.snp.centerY).offset(-8)
        }
        numberOfVotesLabel.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(16)
            $0.top.equalTo(self.snp.centerY)
        }
        votesIndicatorBackView.snp.makeConstraints {
            $0.left.equalTo(iconView.snp.right).offset(16)
            $0.top.equalTo(numberOfVotesLabel.snp.bottom).offset(8)
            $0.width.equalTo(Const.indicatorWidth)
            $0.height.equalTo(8)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailResultVoteCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.contestResult.iconUrl }
            .distinctUntilChanged()
            .bind { [weak self] iconUrl in
                self?.iconView.setImage(imageUrl: iconUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contestResult.animalName }
            .distinctUntilChanged()
            .bind(to: animalNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contestResult.numberOfVotes }
            .distinctUntilChanged()
            .map { "\($0)票" }
            .bind(to: numberOfVotesLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contestResult }
            .distinctUntilChanged()
            .bind { [weak self] contestResult in
                guard let self = self else { return }
                self.removeConstraints(self.votesIndicatorFrontView.constraints)
                self.votesIndicatorFrontView.snp.makeConstraints {
                    $0.left.equalTo(self.iconView.snp.right).offset(16)
                    $0.top.equalTo(self.numberOfVotesLabel.snp.bottom).offset(8)
                    $0.width.equalTo(Const.indicatorWidth * CGFloat(contestResult.numberOfVotes / contestResult.maxOfVotes))
                    $0.height.equalTo(8)
                }
            }
            .disposed(by: disposeBag)
    }
}
