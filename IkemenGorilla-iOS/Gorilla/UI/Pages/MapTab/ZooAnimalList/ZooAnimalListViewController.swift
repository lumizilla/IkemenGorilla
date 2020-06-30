//
//  ZooAnimalListViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class ZooAnimalViewController: UIViewController, View, ViewConstructor {
    
    struct Reusable {
        static let animalCell = ReusableCell<ZooAnimalCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let animalsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ZooAnimalCell.Const.itemSize
        $0.minimumLineSpacing = 36
        $0.minimumInteritemSpacing = 16
    }).then {
        $0.register(Reusable.animalCell)
        $0.backgroundColor = Color.white
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 16, left: 24, bottom: 24, right: 24)
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        title = reactor?.currentState.zoo.name
        view.addSubview(animalsCollectionView)
    }
    
    func setupViewConstraints() {
        animalsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ZooAnimalReactor) {
        // Action
        reactor.action.onNext(.loadAnimals)
        
        animalsCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                logger.debug(indexPath)
                let vc = AnimalDetailViewController().then {
                    $0.reactor = reactor.createAnimalDetailReactor(indexPath: indexPath)
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.animalCellReactors }
            .distinctUntilChanged()
            .bind(to: animalsCollectionView.rx.items(Reusable.animalCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
