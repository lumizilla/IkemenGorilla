//
//  FanAnimalDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class FanAnimalDetailViewController: UIViewController, View, ViewConstructor {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let contentScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
        $0.contentInset.top = 16
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let header = FanAnimalDetailHeader()
    
    private let currentContestView = FanAnimalDetailCurrentContestView()
    
    private let pastContestView = FanAnimalDetailPastContestView()
    
    private let postHeader = FanAnimalDetailPostHeader()
    
    private let postCollectionView = PostPhotoCollectionView(isCalculateHeight: true)
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.backgroundColor = Color.white
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(stackView)
        stackView.addArrangedSubview(header)
        stackView.setCustomSpacing(40, after: header)
        stackView.addArrangedSubview(currentContestView)
        stackView.setCustomSpacing(56, after: currentContestView)
        stackView.addArrangedSubview(pastContestView)
        stackView.setCustomSpacing(56, after: pastContestView)
        stackView.addArrangedSubview(postHeader)
        stackView.addArrangedSubview(postCollectionView)
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
    func bind(reactor: FanAnimalDetailReactor) {
        header.reactor = reactor
        currentContestView.reactor = reactor
        pastContestView.reactor = reactor
        postCollectionView.reactor = reactor.createPostPhotoCollectionReactor()
        
        // Action
        reactor.action.onNext(.loadPastContests)
        reactor.action.onNext(.loadPost)
        
        // State
        reactor.state.map { $0.posts }
            .distinctUntilChanged()
            .bind { [weak self] posts in
                self?.postCollectionView.reactor?.action.onNext(.setPosts(posts))
            }
            .disposed(by: disposeBag)
    }
}
