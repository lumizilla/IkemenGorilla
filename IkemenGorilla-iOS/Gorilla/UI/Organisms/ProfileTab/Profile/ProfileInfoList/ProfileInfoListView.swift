//
//  ProfileInfoListView.swift
//  Gorilla
//
//  Created by admin on 2020/06/07.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReusableKit
import ReactorKit
import RxSwift

final class ProfileInfoListView: UICollectionView, View, ViewConstructor {
    private struct Const {
        static let collectionViewContentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        static let minimumLineSpacing: CGFloat = 12
        static let cellWidth: CGFloat = DeviceSize.screenWidth
        static let cellHeight: CGFloat = 150
        static let itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
    
    struct Reusable {
        static let profileInfoCell = ReusableCell<ProfileInfoCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: DeviceSize.screenWidth, height: Const.cellHeight)
    }
    
    struct Callback {
        let itemSelected: (_ profileInfo: Profile) -> Void
    }
    
    // MARK: - Views
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.itemSize = Const.itemSize
        $0.minimumLineSpacing = Const.minimumLineSpacing
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
        register(Reusable.profileInfoCell)
    }
    
    func setupViewConstraints() {}
    
    // MARK: - Bind Method
    func bind(reactor: ProfileInfoReactor) {
        // Action
        reactor.action.onNext(.load)
        
        // State
        reactor.state.map { $0.profileInfoCellReactors }
            .bind(to: rx.items(Reusable.profileInfoCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
