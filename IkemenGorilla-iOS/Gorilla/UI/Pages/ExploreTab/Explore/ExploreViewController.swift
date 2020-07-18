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
    
    struct Reusable {
        static let recommendKeywordCell = ReusableCell<RecommendKeywordCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let searchBar = UISearchBar().then {
        $0.placeholder = "動物、動物園、名前"
        $0.backgroundImage = UIImage()
        $0.tintColor = Color.black
        $0.showsCancelButton = true
    }
    
    private let postsCollectionView = PostPhotoCollectionView(isCalculateHeight: false).then {
        $0.contentInset.top = 8
    }
    
    private let recommendKeywordTableView = UITableView().then {
        $0.register(Reusable.recommendKeywordCell)
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.contentInset.top = RecommendKeywordHeader.Const.height
    }
    
    private let recommendKeywordHeader = RecommendKeywordHeader()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        navigationItem.titleView = searchBar
        view.addSubview(postsCollectionView)
        view.addSubview(recommendKeywordTableView)
        recommendKeywordTableView.addSubview(recommendKeywordHeader)
    }
    
    func setupViewConstraints() {
        postsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        recommendKeywordTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        recommendKeywordHeader.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-RecommendKeywordHeader.Const.height)
            $0.left.right.equalToSuperview()
        }
    }
    
    // MARK: - bind
    func bind(reactor: ExploreReactor) {
        postsCollectionView.reactor = PostPhotoCollectionReactor()
        // Action
        reactor.action.onNext(.refresh)
        
        searchBar.rx.cancelButtonClicked
            .bind { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .distinctUntilChanged()
            .bind { keyword in
                guard let keyword = keyword else { return }
                reactor.action.onNext(.updateKeyword(keyword))
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .bind { [weak self] _ in
                self?.searchBar.resignFirstResponder()
                self?.showExploreSearchResultPage(exploreSearchResultReactor: reactor.createExploreSearchResultReactorFromSearchButton())
            }
            .disposed(by: disposeBag)
        
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
        
        recommendKeywordTableView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.recommendKeywordTableView.deselectRow(at: indexPath, animated: true)
                self?.showExploreSearchResultPage(exploreSearchResultReactor: reactor.createExploreSearchResultReactorFromRecommendKeyword(indexPath: indexPath))
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.posts }
            .distinctUntilChanged()
            .bind { [weak self] posts in
                self?.postsCollectionView.reactor?.action.onNext(.setPosts(posts))
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.recommendKeywords }
            .distinctUntilChanged()
            .bind(to: recommendKeywordTableView.rx.items(Reusable.recommendKeywordCell)) { _, keyword, cell in
                cell.reactor = RecommendKeywordCellReactor(keyword: keyword)
            }
            .disposed(by: disposeBag)
    }
}
