//
//  ProfileContestDetailInfoViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SegementSlide
import ReactorKit
import RxSwift
import ReusableKit

final class ProfileContestDetailInfoViewController: UIViewController, View, ViewConstructor, SegementSlideContentScrollViewDelegate {
    
    struct Reusable {
        static let sponsorCell = ReusableCell<ProfileContestDetailInfoSponsorCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    @objc var scrollView: UIScrollView {
        return sponsorsCollectionView
    }
    
    // MARK: - Views
    private let profileContestDetailInfoHeader = ProfileContestDetailInfoHeader()
    
    private let sponsorsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ProfileContestDetailInfoSponsorCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 16
        $0.headerReferenceSize = CGSize(width: DeviceSize.screenWidth, height: 160)
    }).then {
        $0.register(Reusable.sponsorCell)
        $0.backgroundColor = Color.white
        $0.showsVerticalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
        $0.alpha = 0
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let flowLayout = sponsorsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let height = profileContestDetailInfoHeader.frame.height
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            flowLayout.headerReferenceSize = CGSize(width: DeviceSize.screenWidth, height: height)
            self.sponsorsCollectionView.alpha = 1
        }, completion: nil)
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(sponsorsCollectionView)
        sponsorsCollectionView.addSubview(profileContestDetailInfoHeader)
        
    }
    
    func setupViewConstraints() {
        profileContestDetailInfoHeader.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        sponsorsCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ProfileContestDetailInfoReactor) {
        profileContestDetailInfoHeader.reactor = reactor
        
        // Action
        reactor.action.onNext(.load)
        
        // State
        
        reactor.state.map { $0.sponsorCellReactors }
            .distinctUntilChanged()
            .bind(to: sponsorsCollectionView.rx.items(Reusable.sponsorCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}

