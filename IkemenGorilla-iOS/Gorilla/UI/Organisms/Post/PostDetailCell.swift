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

final class PostDetailCell: UITableViewCell, View, ViewConstructor {
    
    struct Const {
        static let iconImageSize: CGFloat = 40
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let animalIconView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = Const.iconImageSize / 2
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
    }
    
    func setupViewConstraints() {
        animalIconView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.iconImageSize)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: PostCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.post.animalIconUrl }
            .distinctUntilChanged()
            .bind { [weak self] iconUrl in
                self?.animalIconView.setImage(imageUrl: iconUrl)
            }
            .disposed(by: disposeBag)
    }
}
