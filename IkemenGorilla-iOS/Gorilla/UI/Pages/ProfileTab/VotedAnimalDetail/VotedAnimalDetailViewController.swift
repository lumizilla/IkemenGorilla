//
//  VotedAnimalDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/07/19.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class VotedAnimalDetailViewController: UIViewController, View, ViewConstructor, TransitionPresentable {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let contentScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    
    private let header = VotedAnimalDetailHeader()
    
    private let postsCollectionView = PostPhotoCollectionView(isCalculateHeight: true)
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        header.delegate = self
        view.backgroundColor = Color.white
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(stackView)
        stackView.addArrangedSubview(header)
        stackView.addArrangedSubview(postsCollectionView)
    }
    
    func setupViewConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        header.snp.makeConstraints {
            $0.width.equalTo(DeviceSize.screenWidth)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: VotedAnimalDetailReactor) {
        header.reactor = reactor
        postsCollectionView.reactor = reactor.createPostPhotoCollectionReactor()
        
        // Action
        reactor.action.onNext(.loadAnimal)
        reactor.action.onNext(.loadPosts)
        
        postsCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.showExplorePostDetailPage(explorePostDetailReactor: reactor.createExplorePostDetailReactor(indexPath: indexPath))
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

extension VotedAnimalDetailViewController: VotedAnimalDetailHeaderDelegate {
    
    func didTapAnimal() {
        logger.debug("didTapAnimal")
        guard let reactor = reactor else { return }
        showAnimalDetailPage(animalDetailReactor: reactor.createAnimalDetailReactor())
    }
    
    func didTapZoo() {
        guard let reactor = reactor else { return }
        showZooDetailPage(zooDetailReactor: reactor.createZooDetailReactor())
    }
}
