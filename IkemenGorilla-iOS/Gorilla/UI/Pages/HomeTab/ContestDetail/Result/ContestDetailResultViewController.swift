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

final class ContestDetailResultViewController: UIViewController, View, ViewConstructor, SegementSlideContentScrollViewDelegate, TransitionPresentable {
    
    struct Reusable {
        static let awardCell = ReusableCell<ContestDetailResultAwardCell>()
        static let resultCell = ReusableCell<ContestDetailResultVoteCell>()
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
    
    private let awardHeader = UIView().then {
        let label = UILabel().then {
            $0.apply(fontStyle: .medium, size: 20)
            $0.textColor = Color.black
            $0.text = "Award"
        }
        $0.addSubview(label)
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
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
    
    private let resultHeader = UIView().then {
        let label = UILabel().then {
            $0.apply(fontStyle: .medium, size: 20)
            $0.textColor = Color.black
            $0.text = "票数"
        }
        $0.addSubview(label)
        label.snp.makeConstraints {
            $0.left.bottom.equalToSuperview().inset(16)
        }
    }
    
    private let resultsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ContestDetailResultVoteCell.Const.itemSize
        $0.minimumLineSpacing = 0
    }).then {
        $0.register(Reusable.resultCell)
        $0.backgroundColor = Color.white
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = false
    }
    
    private let awardEmptyView = AwardEmptyView()
    
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
        stackView.addArrangedSubview(awardHeader)
        stackView.addArrangedSubview(awardsCollectionView)
        stackView.addArrangedSubview(awardEmptyView)
        stackView.addArrangedSubview(resultHeader)
        stackView.addArrangedSubview(resultsCollectionView)
    }
    
    func setupViewConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        awardHeader.snp.makeConstraints {
            $0.height.equalTo(88)
        }
        resultHeader.snp.makeConstraints {
            $0.height.equalTo(80)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailResultReactor) {
        // Action
        reactor.action.onNext(.load)
        
        awardsCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.showContestAnimalDetailPage(contestAnimalDetailReactor: reactor.createContestAnimalDetailReactorFromAward(indexPath: indexPath))
            }
            .disposed(by: disposeBag)
        
        resultsCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                self?.showContestAnimalDetailPage(contestAnimalDetailReactor: reactor.createContestAnimalDetailReactorFromResult(indexPath: indexPath))
            }
            .disposed(by: disposeBag)
        
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
                self?.awardsCollectionView.removeConstraints(self?.awardsCollectionView.constraints ?? [])
                self?.awardsCollectionView.snp.makeConstraints {
                    $0.height.equalTo(ContestDetailResultAwardCell.Const.cellHeight * CGFloat((count + 1) / 2))
                    $0.width.equalTo(DeviceSize.screenWidth)
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.resultCellReactors }
            .distinctUntilChanged()
            .bind(to: resultsCollectionView.rx.items(Reusable.resultCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.resultCellReactors.count }
            .distinctUntilChanged()
            .bind { [weak self] count in
                self?.resultsCollectionView.removeConstraints(self?.resultsCollectionView.constraints ?? [])
                self?.resultsCollectionView.snp.makeConstraints {
                    $0.height.equalTo(ContestDetailResultVoteCell.Const.cellHeight * CGFloat(count))
                    $0.width.equalTo(DeviceSize.screenWidth)
                }
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.contest.status == "current" }
            .distinctUntilChanged()
            .bind { [weak self] isCurrent in
                logger.debug(isCurrent)
                self?.awardsCollectionView.isHidden = isCurrent
                self?.awardEmptyView.isHidden = !isCurrent
            }
            .disposed(by: disposeBag)
    }
}
