//
//  HomeRecommendedZooViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class HomeRecommendedZooViewController: UIViewController, View, ViewConstructor {
    struct Reusable {
        static let zooCell = ReusableCell<RecommendedZooCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = RecommendedZooCell.Const.itemSize
        $0.scrollDirection = .vertical
    }).then {
        $0.register(Reusable.zooCell)
        $0.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 24, right: 0)
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
        title = "注目の動物園"
        view.addSubview(collectionView)
    }
    
    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: HomeRecommendedZooReactor) {
        // Action
        reactor.action.onNext(.load)
        
        // State
        reactor.state.map { $0.zooCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.zooCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
