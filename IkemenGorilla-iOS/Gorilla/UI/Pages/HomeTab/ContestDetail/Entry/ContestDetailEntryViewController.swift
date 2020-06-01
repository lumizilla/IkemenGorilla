//
//  ContestDetailEntryViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit
import SegementSlide

final class ContestDetailEntryViewController: UIViewController, View, ViewConstructor, SegementSlideContentScrollViewDelegate {
    
    struct Reusable {
        static let entryCell = ReusableCell<ContestDetailEntryCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    @objc var scrollView: UIScrollView {
        return entriesCollectionView
    }
    
    
    // MARK: - Views
    private let entriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ContestDetailEntryCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 16
    }).then {
        $0.register(Reusable.entryCell)
        $0.backgroundColor = Color.white
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(entriesCollectionView)
    }
    
    func setupViewConstraints() {
        entriesCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailEntryReactor) {
        // Action
        reactor.action.onNext(.load)
        
        // State
        reactor.state.map { $0.entryCellReactors }
            .distinctUntilChanged()
            .bind(to: entriesCollectionView.rx.items(Reusable.entryCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
