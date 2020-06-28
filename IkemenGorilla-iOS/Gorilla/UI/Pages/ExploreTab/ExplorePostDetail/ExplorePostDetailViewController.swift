//
//  ExplorePostDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class ExplorePostDetailViewController: UIViewController, View, ViewConstructor {
    
    struct Reusable {
        static let postCell = ReusableCell<PostDetailCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let postsTableView = UITableView().then {
        $0.register(Reusable.postCell)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.allowsSelection = false
        $0.alpha = 0
    }
    
    private let activityIndicator = UIActivityIndicatorView().then {
        $0.startAnimating()
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let startAt = reactor?.currentState.startAt else { return }
        guard let didScrollToItem = reactor?.currentState.didScrollToItem else { return }
        if !didScrollToItem {
            postsTableView.scrollToRow(at: IndexPath(row: startAt, section: 0), at: .top, animated: false)
            reactor?.action.onNext(.didScrollToItem)
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.postsTableView.alpha = 1
            self.activityIndicator.stopAnimating()
        })
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.backgroundColor = Color.white
        view.addSubview(postsTableView)
        view.addSubview(activityIndicator)
    }
    
    func setupViewConstraints() {
        postsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ExplorePostDetailReactor) {
        // Action
        
        // State
        reactor.state.map { $0.postCellReactors }
            .distinctUntilChanged()
            .bind(to: postsTableView.rx.items(Reusable.postCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
