//
//  CreateVoteViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class CreateVoteViewController: UIViewController, View, ViewConstructor {
    
    struct Const {
        static let height: CGFloat = 316
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    let closeButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "close"), for: .normal)
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    private let animalNameLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 24)
        $0.textColor = Color.textBlack
        $0.numberOfLines = 0
    }
    
    private let zooNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 16)
        $0.textColor = Color.textGray
        $0.numberOfLines = 0
    }
    
    private let cancelButton = UIButton().then {
        $0.setTitle("キャンセル", for: .normal)
        $0.titleLabel?.apply(fontStyle: .bold, size: 15)
        $0.setTitleColor(Color.textBlack, for: .normal)
        $0.setTitleColor(Color.textGray, for: .highlighted)
    }
    
    private let voteButton = VoteButton()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(closeButton)
        view.addSubview(imageView)
        view.addSubview(animalNameLabel)
        view.addSubview(zooNameLabel)
        view.addSubview(cancelButton)
        view.addSubview(voteButton)
    }
    
    func setupViewConstraints() {
        closeButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(24)
            $0.size.equalTo(32)
        }
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.left.equalToSuperview().inset(16)
            $0.width.equalTo(176)
            $0.height.equalTo(156)
        }
        animalNameLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(zooNameLabel.snp.top).offset(-12)
        }
        zooNameLabel.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(imageView)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(24)
            $0.right.equalTo(view.snp.centerX).offset(-32)
        }
        voteButton.snp.makeConstraints {
            $0.centerY.equalTo(cancelButton)
            $0.left.equalTo(zooNameLabel)
            $0.width.equalTo(96)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: VoteContestDetailReactor) {
        // Action
        
        // State
        reactor.state.map { $0.voteEntry?.iconUrl }
            .distinctUntilChanged()
            .bind { [weak self] iconUrl in
                guard let iconUrl = iconUrl else { return }
                self?.imageView.setImage(imageUrl: iconUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.voteEntry?.name }
            .distinctUntilChanged()
            .bind(to: animalNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.voteEntry?.zooName }
            .distinctUntilChanged()
            .bind(to: zooNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
