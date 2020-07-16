//
//  PostDetailCell.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxGesture

protocol PostDetailCellDelegate {
    func didTapAnimal(zooAnimal: ZooAnimal) -> Void
}

final class PostDetailCell: UITableViewCell, ReactorKit.View, ViewConstructor {
    
    struct Const {
        static let iconImageSize: CGFloat = 40
        static let postImageHeight: CGFloat = 280
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    var delegate: PostDetailCellDelegate?
    
    // MARK: - Views
    private let animalIconView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Const.iconImageSize / 2
    }
    
    private let animalNameLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 15)
        $0.textColor = Color.textBlack
    }
    
    private let zooNameLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textGray
    }
    
    private let postImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let descriptionLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textGray
        $0.numberOfLines = 0
    }
    
    private let dateLabel = UILabel().then {
        $0.apply(fontStyle: .regular, size: 11)
        $0.textColor = Color.textGray
    }
        
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        contentView.addSubview(animalIconView)
        contentView.addSubview(animalNameLabel)
        contentView.addSubview(zooNameLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
    }
    
    func setupViewConstraints() {
        animalIconView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.iconImageSize)
        }
        animalNameLabel.snp.makeConstraints {
            $0.left.equalTo(animalIconView.snp.right).offset(8)
            $0.top.equalTo(animalIconView)
        }
        zooNameLabel.snp.makeConstraints {
            $0.left.equalTo(animalIconView.snp.right).offset(8)
            $0.bottom.equalTo(animalIconView)
        }
        postImageView.snp.makeConstraints {
            $0.top.equalTo(animalIconView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(Const.postImageHeight)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: PostCellReactor) {
        // Action
        animalIconView.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.delegate?.didTapAnimal(zooAnimal: reactor.createZooAnimal())
            }
            .disposed(by: disposeBag)
        
        animalNameLabel.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.delegate?.didTapAnimal(zooAnimal: reactor.createZooAnimal())
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.post.animalIconUrl }
            .distinctUntilChanged()
            .bind { [weak self] iconUrl in
                self?.animalIconView.setImage(imageUrl: iconUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.post.animalName }
            .distinctUntilChanged()
            .bind(to: animalNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.post.zooName }
            .distinctUntilChanged()
            .bind(to: zooNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.post.imageUrl }
            .distinctUntilChanged()
            .bind { [weak self] imageUrl in
                self?.postImageView.setImage(imageUrl: imageUrl)
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.post.description }
            .distinctUntilChanged()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.post.createdAt }
            .distinctUntilChanged()
            .map { formatter.string(from: $0) }
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        // Variables
        disposeBag = DisposeBag()
        
        // Views
        animalIconView.image = #imageLiteral(resourceName: "noimage")
        animalNameLabel.text = ""
        zooNameLabel.text = ""
    }
}
