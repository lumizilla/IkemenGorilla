//
//  ContestDetailHeader.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ContestDetailHeader: UIView, View, ViewConstructor {
    
    struct Const {
        static let imageViewHeight: CGFloat = 240
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let contestNameLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 24)
        $0.textColor = Color.textBlack
        $0.numberOfLines = 0
    }
    
    private let durationLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 13)
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
            $0.height.equalTo(Const.imageViewHeight)
        }
        contestNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        durationLabel.snp.makeConstraints {
            $0.top.equalTo(contestNameLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailReactor) {
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
        
        
        reactor.state.map { $0.contest }
            .distinctUntilChanged()
            .map { contest in
                var durationString = "開催期間："
                durationString += formatter.string(from: contest.start)
                durationString += " ~ "
                durationString += formatter.string(from: contest.end)
                return durationString
            }
            .bind(to: durationLabel.rx.text)
            .disposed(by: disposeBag)
    }
}


