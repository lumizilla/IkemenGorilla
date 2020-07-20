//
//  FanAnimalViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/11.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class FanAnimalViewController: UIViewController, View, ViewConstructor, TransitionPresentable {
    struct Reusable {
        static let animalCell = ReusableCell<FanAnimalCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = FanAnimalCell.Const.itemSize
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 36
        $0.minimumInteritemSpacing = 16
    }).then {
        $0.register(Reusable.animalCell)
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
        title = "ファンの動物"
        view.addSubview(collectionView)
    }
    
    func setupViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: FanAnimalReactor) {
        // Action
        reactor.action.onNext(.refresh)
        
        collectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.showAnimalDetailPage(animalDetailReactor: reactor.createAnimalDetailReactor(indexPath: indexPath))
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.contentOffset
            .distinctUntilChanged()
            .bind { [weak self] contentOffset in
                guard let collectionView = self?.collectionView else { return }
                if collectionView.contentOffset.y + collectionView.frame.size.height > collectionView.contentSize.height {
                    reactor.action.onNext(.load)
                }
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.animalCellReactors }
            .distinctUntilChanged()
            .bind(to: collectionView.rx.items(Reusable.animalCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
