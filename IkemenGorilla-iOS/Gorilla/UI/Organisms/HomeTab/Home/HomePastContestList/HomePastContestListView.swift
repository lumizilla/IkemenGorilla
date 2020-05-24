//
//  HomePastContestListView.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReusableKit
import ReactorKit
import RxSwift

final class HomePastContestListView: UICollectionView, View, ViewConstructor {
    private struct Const {
        static let collectionViewContentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        static let minimumLineSpacing: CGFloat = 12
        static let minimumInteritemSpacing: CGFloat = 24
        static let cellWidth: CGFloat = (DeviceSize.screenWidth - 60) / 2
        static let cellHeight: CGFloat = cellWidth * 208 / 156
        static let itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    struct Reusable {
        static let contestListCell = ReusableCell<HomePastContestListCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: Const.cellHeight * 2 + 24)
    }
    
    // MARK: - Views
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = Const.itemSize
        $0.minimumLineSpacing = Const.minimumLineSpacing
        $0.minimumInteritemSpacing = Const.minimumInteritemSpacing
        $0.scrollDirection = .horizontal
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        setupViews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup Methods
    func setupViews() {
        backgroundColor = Color.white
        contentInset = Const.collectionViewContentInset
        showsHorizontalScrollIndicator = false
        register(Reusable.contestListCell)
    }
    
    func setupViewConstraints() {}
    
    // MARK: - Bind Method
    func bind(reactor: HomePastContestListReactor) {
        // Action
        reactor.action.onNext(.load)
        
        // State
        reactor.state.map { $0.contestListCellReactors }
            .bind(to: rx.items(Reusable.contestListCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
