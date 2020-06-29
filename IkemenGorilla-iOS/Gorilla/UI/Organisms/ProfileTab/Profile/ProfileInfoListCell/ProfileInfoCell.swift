//
//  ProfileInfoCell.swift
//  Gorilla
//
//  Created by admin on 2020/06/06.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ProfileInfoCell: UICollectionViewCell, View, ViewConstructor {
    
    struct Const {
        static let cellWidth: CGFloat = DeviceSize.screenWidth
        static let cellHeight: CGFloat = 400
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
        static let imageViewSize: CGSize = CGSize(width: 80, height: 80)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 40
    }
    private let space = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.text = ""
    }
    private let profileNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 24)
        $0.textColor = Color.black
        $0.numberOfLines = 0
    }
    private let border = UIView().then {
        $0.backgroundColor = Color.borderGray
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
        addSubview(space)
        addSubview(profileNameLabel)
        addSubview(space)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Const.imageViewSize)
        }
        space.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.right.left.equalToSuperview()
        }
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(space.snp.bottom).inset(1)
            $0.centerX.equalToSuperview()
        }
        space.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(50)
            $0.right.left.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ProfileInfoCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.profile.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.imageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.profile.name }
            .distinctUntilChanged()
            .bind(to: profileNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
