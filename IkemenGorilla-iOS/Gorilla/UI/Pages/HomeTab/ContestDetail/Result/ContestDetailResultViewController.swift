//
//  ContestDetailResultViewController.swift
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

final class ContestDetailResultViewController: UIViewController, View, ViewConstructor, SegementSlideContentScrollViewDelegate {
    
    struct Reusable {
        static let awardCell = ReusableCell<ContestDetailResultAwardCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    @objc var scrollView: UIScrollView {
        return contentScrollView
    }
    
    // MARK: - Views
    private let contentScrollView = UIScrollView()
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let awardsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ContestDetailResultAwardCell.Const.itemSize
        $0.minimumLineSpacing = 0
        $0.minimumInteritemSpacing = 16
    }).then {
        $0.register(Reusable.awardCell)
        $0.backgroundColor = Color.white
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.isScrollEnabled = false
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
        stackView.addArrangedSubview(awardsCollectionView)
    }
    
    func setupViewConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        awardsCollectionView.snp.makeConstraints {
            $0.height.equalTo(ContestDetailResultAwardCell.Const.cellHeight * 4)
            $0.width.equalTo(DeviceSize.screenWidth)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailResultReactor) {
        // Action
        reactor.action.onNext(.load)
        
        // State
        reactor.state.map { $0.awardCellReactors }
            .distinctUntilChanged()
            .bind(to: awardsCollectionView.rx.items(Reusable.awardCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.awardCellReactors.count }
            .distinctUntilChanged()
            .bind { [weak self] count in
                self?.stackView.removeConstraints(self?.awardsCollectionView.constraints ?? [])
                self?.awardsCollectionView.snp.makeConstraints {
                    $0.height.equalTo(ContestDetailResultAwardCell.Const.cellHeight * 4)
                    $0.width.equalTo(DeviceSize.screenWidth)
                }
            }
            .disposed(by: disposeBag)
    }
}
