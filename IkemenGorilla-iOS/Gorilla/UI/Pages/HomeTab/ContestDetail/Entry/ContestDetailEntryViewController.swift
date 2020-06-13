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

final class ContestDetailEntryViewController: UIViewController, View, ViewConstructor, SegementSlideContentScrollViewDelegate, TransitionPresentable {
    
    struct Reusable {
        static let entryCell = ReusableCell<ContestDetailEntryCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    @objc var scrollView: UIScrollView {
        return entriesCollectionView
    }
    
    // MARK: - Views
    private let titleLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 20)
        $0.textColor = Color.black
    }
    
    private let entriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ContestDetailEntryCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 16
        $0.headerReferenceSize = CGSize(width: DeviceSize.screenWidth, height: 56)
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
        entriesCollectionView.addSubview(titleLabel)
    }
    
    func setupViewConstraints() {
        entriesCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailEntryReactor) {
        // Action
        reactor.action.onNext(.load)
        
        entriesCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.showContestAnimalDetailPage(contestAnimalDetailReactor: reactor.createContestAnimalDetailReactor(indexPath: indexPath))
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.entryCellReactors }
            .distinctUntilChanged()
            .bind(to: entriesCollectionView.rx.items(Reusable.entryCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.entryCellReactors.count }
            .distinctUntilChanged()
            .map { "\($0)匹の動物たち" }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
