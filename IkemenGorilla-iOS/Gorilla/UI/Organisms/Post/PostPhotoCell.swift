//
//  PostPhotoCell.swift
//  Gorilla
//
//  Created by admin on 2020/06/26.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class PostPhotoCell: UICollectionViewCell, View, ViewConstructor {
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
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
        layer.masksToBounds = true
        layer.cornerRadius = 4
        addSubview(imageView)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: PostCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.post.imageUrls }
            .distinctUntilChanged()
            .bind { [weak self] imageUrls in
                if !imageUrls.isEmpty {
                    self?.imageView.setImage(imageUrl: imageUrls[0])
                }
            }
            .disposed(by: disposeBag)
    }
}
