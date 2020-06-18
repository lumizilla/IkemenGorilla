//
//  ZooDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift
import ReusableKit

final class ZooDetailViewController: UIViewController, View, ViewConstructor {
    
    struct Reusable {
        static let animalCell = ReusableCell<ZooDetailAnimalCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let contentScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let header = ZooDetailHeader()
    
    private let animalsHeader = ZooDetailAnimalsHeader()
    
    private let animalsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ZooDetailAnimalCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.scrollDirection = .horizontal
    }).then {
        $0.register(Reusable.animalCell)
        $0.backgroundColor = Color.white
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(stackView)
        stackView.addArrangedSubview(header)
        stackView.addArrangedSubview(animalsHeader)
        stackView.addArrangedSubview(animalsCollectionView)
    }
    
    func setupViewConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        header.snp.makeConstraints {
            $0.width.equalTo(DeviceSize.screenWidth)
        }
        animalsCollectionView.snp.makeConstraints {
            $0.width.equalTo(DeviceSize.screenWidth)
            $0.height.equalTo(96)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ZooDetailReactor) {
        header.reactor = reactor
        // Action
        reactor.action.onNext(.loadAnimals)
        
        // State
        reactor.state.map { $0.animalCellReactors }
            .distinctUntilChanged()
            .bind(to: animalsCollectionView.rx.items(Reusable.animalCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
