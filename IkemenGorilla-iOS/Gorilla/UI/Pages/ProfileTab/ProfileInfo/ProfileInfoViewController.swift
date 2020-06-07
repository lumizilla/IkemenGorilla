//
//  ProfileInfoViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/06.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class ProfileInfoViewController: UIViewController, View, ViewConstructor {
    struct Reusable {
        static let profileCell = ReusableCell<ProfileInfoCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ProfileInfoCell.Const.itemSize
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
    }).then {
        $0.register(Reusable.profileCell)
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
        title = "プロフィール"
        view.addSubview(collectionView)
    }
    
    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ProfileInfoReactor) {
        // Action
        reactor.action.onNext(.load)
        
        // State
        reactor.state.map { $0.profileInfoCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.profileCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}

