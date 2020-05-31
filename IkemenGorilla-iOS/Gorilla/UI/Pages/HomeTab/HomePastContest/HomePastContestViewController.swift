//
//  HomePastContestViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReusableKit
import ReactorKit
import RxSwift

final class HomePastContestViewController: UIViewController, View, ViewConstructor {
    
    struct Reusable {
        static let contestCell = ReusableCell<HomePastContestCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = HomePastContestCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 24
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.contestCell)
    }
    
    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(collectionView)
    }
    
    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: HomePastContestReactor) {
        // Action
        
        // State
        reactor.state.map { $0.contestCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.contestCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
