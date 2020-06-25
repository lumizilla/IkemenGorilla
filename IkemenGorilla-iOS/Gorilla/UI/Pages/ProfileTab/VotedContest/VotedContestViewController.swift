//
//  VotedContestViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/11.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class VotedContestViewController: UIViewController, View, ViewConstructor {
    struct Reusable {
        static let contestCell = ReusableCell<VotedContestCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = VotedContestCell.Const.itemSize
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 12
    }).then {
        $0.register(Reusable.contestCell)
        $0.contentInset = UIEdgeInsets(top: 16, left: 24, bottom: 24, right: 24)
        $0.backgroundColor = Color.white
    }
    
    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        title = "投票したコンテスト"
        view.addSubview(collectionView)
    }
    
    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: VotedContestReactor) {
        // Action
        reactor.action.onNext(.load)
        
        // State
        reactor.state.map { $0.contestCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.contestCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
