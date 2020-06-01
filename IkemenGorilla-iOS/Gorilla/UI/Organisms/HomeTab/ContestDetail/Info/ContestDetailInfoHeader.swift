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
            $0.bottom.equalToSuperview()
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
        
        reactor.state.map { $0.contest.description }
            .distinctUntilChanged()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
