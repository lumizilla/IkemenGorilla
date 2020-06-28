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

final class ExploreViewController: UIViewController, View, ViewConstructor {
    
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
        reactor.action.onNext(.loadPosts)
        
        postsCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                logger.debug(indexPath)
                let vc = ExplorePostDetailViewController().then {
                    $0.reactor = reactor.createExplorePostDetailReactor(indexPath: indexPath)
                }
                self?.navigationController?.pushViewController(vc, animated: true)
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
