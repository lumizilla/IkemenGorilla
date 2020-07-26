//
//  AnimalDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/25.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift

final class AnimalDetailViewController: UIViewController, View, ViewConstructor, TransitionPresentable {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let fanButton = FanButton()
    
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
    
    private let header = AnimalDetailHeader()
    
    private let currentContestView = AnimalDetailCurrentContestView()
    
    private let pastContestView = AnimalDetailPastContestView()
    
    private let postHeader = AnimalDetailPostHeader()
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: fanButton)
        
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
        fanButton.snp.makeConstraints {
            $0.width.equalTo(120)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: AnimalDetailReactor) {
        header.reactor = reactor
        currentContestView.reactor = reactor
        pastContestView.reactor = reactor
        postCollectionView.reactor = reactor.createPostPhotoCollectionReactor()
        
        // Action
        reactor.action.onNext(.loadAnimal)
        reactor.action.onNext(.loadCurrentContest)
        reactor.action.onNext(.loadPastContests)
        reactor.action.onNext(.loadPost)
        
        postCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                logger.debug(indexPath)
                self?.showExplorePostDetailPage(explorePostDetailReactor: reactor.createExplorePostDetailReactor(indexPath: indexPath))
            }
            .disposed(by: disposeBag)
        
        fanButton.rx.tap
            .bind {
                reactor.action.onNext(.tapFanButton)
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.posts }
            .distinctUntilChanged()
            .bind { [weak self] posts in
                self?.postCollectionView.reactor?.action.onNext(.setPosts(posts))
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.animal?.isFan }
            .distinctUntilChanged()
            .bind { [weak self] isFan in
                guard let isFan = isFan else { return }
                self?.fanButton.isFan = isFan
            }
            .disposed(by: disposeBag)
    }
}
