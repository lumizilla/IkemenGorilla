//
//  ProfileVotedContestListCell.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ProfileVotedContestListCell: UICollectionViewCell, View, ViewConstructor {
    
    struct Const {
        static let cellWidth: CGFloat = (DeviceSize.screenWidth - 64) / 2
        static let cellHeight: CGFloat = cellWidth + 48
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    private let contestNameLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 14)
        $0.textColor = Color.textBlack
    }
    
    private let durationLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 14)
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
        addSubview(contestNameLabel)
        addSubview(durationLabel)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.cellWidth)
        }
        contestNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(8)
        }
        durationLabel.snp.makeConstraints {
            $0.top.equalTo(contestNameLabel.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        // Variables
        disposeBag = DisposeBag()
        
        // Views
        durationLabel.text = ""
        contestNameLabel.text = ""
        imageView.image = #imageLiteral(resourceName: "noimage")
    }
    
    // MARK: - Bind Method
    func bind(reactor: ProfileVotedContestListCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.contest.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contest.name }
            .distinctUntilChanged()
            .bind(to: contestNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map {
                var durationString = ""
                durationString += formatter.string(from: $0.contest.start)
                durationString += " ~ "
                durationString += formatter.string(from: $0.contest.end)
                return durationString
            }
            .distinctUntilChanged()
            .bind(to: durationLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

