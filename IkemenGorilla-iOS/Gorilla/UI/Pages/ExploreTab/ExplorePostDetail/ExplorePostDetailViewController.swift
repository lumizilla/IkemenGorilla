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
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(postsTableView)
    }
    
    func setupViewConstraints() {
        postsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
