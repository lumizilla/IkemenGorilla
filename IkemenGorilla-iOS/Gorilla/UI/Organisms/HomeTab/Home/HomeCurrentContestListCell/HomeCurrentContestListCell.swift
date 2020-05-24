//
//  HomeCurrentContestListCell.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class HomeCurrentContestListCell: UICollectionViewCell, View, ViewConstructor {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let durationLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 10)
        $0.textColor = Color.teal
    }
    
    private let contestNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 21)
        $0.textColor = Color.textBlack
    }
    
    private let catchCopyLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 21)
        $0.textColor = Color.gray
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    private let formatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd"
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
        addSubview(durationLabel)
        addSubview(contestNameLabel)
        addSubview(catchCopyLabel)
        addSubview(imageView)
    }
    
    func setupViewConstraints() {
        durationLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
        }
        contestNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.right.left.equalToSuperview()
            $0.height.equalTo(24)
        }
        catchCopyLabel.snp.makeConstraints {
            $0.top.equalTo(contestNameLabel.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(catchCopyLabel.snp.bottom).offset(8)
            $0.right.left.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        // Variables
        disposeBag = DisposeBag()
        
        // Views
        durationLabel.text = ""
        contestNameLabel.text = ""
        catchCopyLabel.text = ""
        imageView.image = #imageLiteral(resourceName: "loading")
    }
    
    // MARK: - Bind Method
    func bind(reactor: HomeCurrentContestListCellReactor) {
        // Action
        
        // State
        reactor.state
            .map {
                var dateString = ""
                dateString += self.formatter.string(from: $0.contest.start)
                dateString += " ~ "
                dateString += self.formatter.string(from: $0.contest.end)
                return dateString
            }
            .distinctUntilChanged()
            .bind(to: durationLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contest.name }
            .distinctUntilChanged()
            .bind(to: contestNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contest.catchCopy }
            .distinctUntilChanged()
            .bind(to: catchCopyLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contest.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
    }
}
