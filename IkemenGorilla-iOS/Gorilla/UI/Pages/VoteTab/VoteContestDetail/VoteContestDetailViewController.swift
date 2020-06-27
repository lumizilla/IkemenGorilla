//
//  VoteContestDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit
import FloatingPanel

final class VoteContestDetailViewController: UIViewController, View, ViewConstructor {
    
    struct Const {
        static let rowHeight: CGFloat = ContestDetailEntryCell.Const.cellHeight + 16
    }
    
    struct Reusable {
        static let entryCell = ReusableCell<ContestDetailEntryCell>()
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
    
    private let header = VoteContestDetailHeader()
    
    private let entriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ContestDetailEntryCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 16
    }).then {
        $0.register(Reusable.entryCell)
        $0.backgroundColor = Color.white
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.alwaysBounceVertical = true
    }
    
    private let floatingPanelController = FloatingPanelController().then {
        $0.surfaceView.cornerRadius = 32
    }
    
    private let createVoteViewController = CreateVoteViewController()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
        setupFloatingController()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.backgroundColor = Color.white
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(stackView)
        stackView.addArrangedSubview(header)
        stackView.addArrangedSubview(entriesCollectionView)
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
    }
    
    func setupFloatingController() {
        floatingPanelController.set(contentViewController: createVoteViewController)
        floatingPanelController.addPanel(toParent: self)
        floatingPanelController.delegate = self
    }
    
    // MARK: - Bind Method
    func bind(reactor: VoteContestDetailReactor) {
        header.reactor = reactor
        createVoteViewController.reactor = reactor
        
        // Action
        reactor.action.onNext(.loadEntries)
        
        entriesCollectionView.rx.itemSelected
            .bind { [weak self] indexPath in
                logger.debug(indexPath)
                reactor.action.onNext(.selectEntry(indexPath))
                self?.floatingPanelController.move(to: .full, animated: true)
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.entryCellReactors }
            .distinctUntilChanged()
            .bind(to: entriesCollectionView.rx.items(Reusable.entryCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { ($0.entryCellReactors.count + 1) / 2 }
        .distinctUntilChanged()
            .bind { [weak self] rowCount in
                logger.debug(rowCount)
                self?.entriesCollectionView.removeConstraints(self?.entriesCollectionView.constraints ?? [])
                self?.entriesCollectionView.snp.makeConstraints {
                    $0.height.equalTo(CGFloat(rowCount) * Const.rowHeight)
                }
        }
    }
}

extension VoteContestDetailViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        VoteContestDetailPanelLayout.fullPosition = DeviceSize.screenHeight - (DeviceSize.navBarHeight(self.navigationController) + CreateVoteViewController.Const.height + DeviceSize.tabBarHeight(self.tabBarController))
        return VoteContestDetailPanelLayout()
    }
    
    func floatingPanelShouldBeginDragging(_ vc: FloatingPanelController) -> Bool {
        return true
    }
}

class VoteContestDetailPanelLayout: FloatingPanelLayout {
    static var fullPosition: CGFloat = 0
    
    var initialPosition: FloatingPanelPosition {
        return .hidden
    }

    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return VoteContestDetailPanelLayout.fullPosition
        case .half: return 0
        case .tip: return 0
        default: return nil
        }
    }
}
