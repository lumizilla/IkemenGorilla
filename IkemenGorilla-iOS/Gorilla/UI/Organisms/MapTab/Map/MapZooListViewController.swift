//
//  MapZooListViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/17.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class MapZooListViewController: UIViewController, View, ViewConstructor {
    struct Const {
        static let height: CGFloat = 88 + MapZooCell.Const.itemHeight + 60
    }
    
    struct Reusable {
        static let zooCell = ReusableCell<MapZooCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let headerLabel = UILabel().then {
        $0.apply(fontStyle: .black, size: 24)
        $0.textColor = Color.textBlack
    }
    
    let closeButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "close"), for: .normal)
    }
    
    let zoosCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = MapZooCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.scrollDirection = .horizontal
    }).then {
        $0.register(Reusable.zooCell)
        $0.backgroundColor = Color.white
        $0.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
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
        view.addSubview(headerLabel)
        view.addSubview(closeButton)
        view.addSubview(zoosCollectionView)
    }
    
    func setupViewConstraints() {
        headerLabel.snp.makeConstraints {
            $0.centerY.equalTo(closeButton)
            $0.left.equalToSuperview().inset(32)
            $0.right.equalTo(closeButton.snp.left).offset(8)
        }
        closeButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(24)
            $0.size.equalTo(32)
        }
        zoosCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(88)
            $0.left.right.equalToSuperview()
            $0.width.equalTo(DeviceSize.screenWidth)
            $0.height.equalTo(MapZooCell.Const.itemHeight)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: MapReactor) {
        // Action
        
        // State
        reactor.state.map { $0.selectedAnnotations.count }
            .distinctUntilChanged()
            .map { count in "\(count)件の動物園"}
            .bind(to: headerLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.selectedAnnotations }
            .distinctUntilChanged()
            .map { annotations in
                return annotations.map { MapZooCellReactor(zoo: $0.zoo) }
            }
            .bind(to: zoosCollectionView.rx.items(Reusable.zooCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
    }
}
