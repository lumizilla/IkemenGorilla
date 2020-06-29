//
//  ContestDetailInfoHeader.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ContestDetailInfoHeader: UIView, View, ViewConstructor {
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let catchCopyLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.textColor = Color.black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 13)
        $0.textColor = Color.textGray
        $0.numberOfLines = 0
    }
    
    private let numberOfEntriesLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textBlack
    }
    
    private let numberOfVotedPeopleLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textBlack
    }
    
    private let numberOfVotesLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textBlack
    }
    
    private let wayOfVoteLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textBlack
        $0.text = "投票の方法：1人1日1票まで投票できます"
    }
    
    private let sponsorHeaderLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.textColor = Color.black
        $0.text = "SPONSOR"
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
        addSubview(catchCopyLabel)
        addSubview(descriptionLabel)
        addSubview(numberOfEntriesLabel)
        addSubview(numberOfVotedPeopleLabel)
        addSubview(numberOfVotesLabel)
        addSubview(wayOfVoteLabel)
        addSubview(sponsorHeaderLabel)
    }
    
    func setupViewConstraints() {
        catchCopyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(catchCopyLabel.snp.bottom).offset(24)
            $0.left.right.equalToSuperview()
            $0.width.equalTo(DeviceSize.screenWidth - 32)
        }
        numberOfEntriesLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview()
        }
        numberOfVotedPeopleLabel.snp.makeConstraints {
            $0.top.equalTo(numberOfEntriesLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview()
        }
        numberOfVotesLabel.snp.makeConstraints {
            $0.top.equalTo(numberOfVotedPeopleLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview()
        }
        wayOfVoteLabel.snp.makeConstraints {
            $0.top.equalTo(numberOfVotesLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview()
        }
        sponsorHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(wayOfVoteLabel.snp.bottom).offset(36)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailInfoReactor) {
        // Action
        
        // State
        reactor.state.map { $0.contest.catchCopy }
            .distinctUntilChanged()
            .bind(to: catchCopyLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contestDetail?.description }
            .distinctUntilChanged()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contestDetail?.numberOfEntries }
            .distinctUntilChanged()
            .map { number in
                guard let number = number else { return "" }
                 return "エントリー数：\(number)"
            }
            .bind(to: numberOfEntriesLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contestDetail?.numberOfVotedPeople }
            .distinctUntilChanged()
            .map { number in
                guard let number = number else { return "" }
                 return "これまでの参加人数：\(number)"
            }
            .bind(to: numberOfVotedPeopleLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contestDetail?.numberOfVotes }
            .distinctUntilChanged()
            .map { number in
                guard let number = number else { return "" }
                 return "これまでの投票数：\(number)"
            }
            .bind(to: numberOfVotesLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
