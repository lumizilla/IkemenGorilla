//
//  AnimalDetailPastContestView.swift
//  Gorilla
//
//  Created by admin on 2020/06/25.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class AnimalDetailPastContestView: UIView, View, ViewConstructor {
    struct Const {
        static let height: CGFloat = 24 + 24 + AnimalDetailPastContestCell.Const.cellHeight + 24
    }
    
    struct Reusable {
        static let contestCell = ReusableCell<AnimalDetailPastContestCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: Const.height)
    }
    
    // MARK: - Views
    private let pastContestLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.textColor = Color.textBlack
        $0.text = "過去に参加したコンテスト"
    }
    
    private let contestsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = AnimalDetailPastContestCell.Const.itemSize
        $0.minimumLineSpacing = 12
        $0.scrollDirection = .horizontal
    }).then {
        $0.backgroundColor = Color.white
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.showsHorizontalScrollIndicator = false
        $0.register(Reusable.contestCell)
        $0.alwaysBounceHorizontal = true
    }
    
    let emptyImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = #imageLiteral(resourceName: "empty_state")
    }
    
    let emptyLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 16)
        $0.textColor = Color.textGray
        $0.text = "過去に参加したコンテストはありません"
        $0.numberOfLines = 0
        $0.textAlignment = .center
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
    
    // MARK: - Setup Views
    func setupViews() {
        addSubview(pastContestLabel)
        addSubview(contestsCollectionView)
        addSubview(emptyImageView)
        addSubview(emptyLabel)
    }
    
    func setupViewConstraints() {
        pastContestLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
            $0.width.equalTo(DeviceSize.screenWidth - 32)
            $0.height.equalTo(24)
        }
        contestsCollectionView.snp.makeConstraints {
            $0.top.equalTo(pastContestLabel.snp.bottom).offset(24)
            $0.width.equalTo(DeviceSize.screenWidth)
            $0.height.equalTo(AnimalDetailPastContestCell.Const.cellHeight)
        }
        emptyImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(48)
            $0.width.equalTo(DeviceSize.screenWidth - 32)
            $0.left.equalToSuperview().inset(16)
            $0.height.equalTo(AnimalDetailPastContestCell.Const.cellWidth)
        }
        emptyLabel.snp.makeConstraints {
            $0.centerX.equalTo(emptyImageView)
            $0.width.equalTo(DeviceSize.screenWidth - 32)
            $0.height.equalTo(24)
            $0.bottom.equalTo(emptyImageView).offset(32)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: AnimalDetailReactor) {
        // Action
        
        // State
        reactor.state.map { $0.pastContestCellReactors }
            .distinctUntilChanged()
            .bind(to: contestsCollectionView.rx.items(Reusable.contestCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.pastContestCellReactors.count != 0 }
            .distinctUntilChanged()
            .bind(to: emptyLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.pastContestCellReactors.count != 0 }
            .distinctUntilChanged()
            .bind(to: emptyImageView.rx.isHidden)
            .disposed(by: disposeBag)
    }
}
