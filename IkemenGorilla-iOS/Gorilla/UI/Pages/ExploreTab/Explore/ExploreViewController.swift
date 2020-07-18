//
//  ExploreViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class ExploreViewController: UIViewController, View, ViewConstructor, TransitionPresentable {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let postsCollectionView = PostPhotoCollectionView(isCalculateHeight: false).then {
        $0.contentInset.top = 8
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(postsCollectionView)
    }
    
    func setupViewConstraints() {
        postsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - bind
    func bind(reactor: ExploreReactor) {
        postsCollectionView.reactor = PostPhotoCollectionReactor()
        // Action
        reactor.action.onNext(.refresh)
        
        postsCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                logger.debug(indexPath)
                self?.showExplorePostDetailPage(explorePostDetailReactor: reactor.createExplorePostDetailReactor(indexPath: indexPath))
            }
            .disposed(by: disposeBag)
        
        postsCollectionView.rx.contentOffset
            .distinctUntilChanged()
            .bind { [weak self] contentOffset in
                guard let scrollView = self?.postsCollectionView else { return }
                if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height {
                    reactor.action.onNext(.load)
                }
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.posts }
            .distinctUntilChanged()
            .bind { [weak self] posts in
                self?.postsCollectionView.reactor?.action.onNext(.setPosts(posts))
            }
            .disposed(by: disposeBag)
    }
}
