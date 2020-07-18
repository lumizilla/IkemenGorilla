//
//  MapSearchViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class MapSearchViewController: UIViewController, View, ViewConstructor {
    
    struct Reusable {
        static let resultCell = ReusableCell<MapSearchResultCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    
    private let searchBar = UISearchBar().then {
        $0.placeholder = "動物園、住所"
        $0.backgroundImage = UIImage()
        $0.tintColor = Color.black
        $0.showsCancelButton = true
    }
    
    private let resultCountLabel = UILabel().then {
        $0.apply(fontStyle: .bold, size: 24)
        $0.textColor = Color.textBlack
    }
    
    private let searchResultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = MapSearchResultCell.Const.itemSize
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 0
    }).then {
        $0.register(Reusable.resultCell)
        $0.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 24, right: 0)
        $0.backgroundColor = Color.white
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.backgroundColor = Color.white
        navigationItem.leftBarButtonItem = cancelButton
        view.addSubview(searchResultCollectionView)
        view.addSubview(searchBar)
        searchResultCollectionView.addSubview(resultCountLabel)
    }
    
    func setupViewConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(64)
        }
        searchResultCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        resultCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-56 + 16)
            $0.left.equalTo(view).inset(16)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: MapSearchReactor) {
        // Action
        cancelButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .bind { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .distinctUntilChanged()
            .bind { keyword in
                logger.debug(keyword)
                reactor.action.onNext(.updateKeyword(keyword ?? ""))
            }
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .bind { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        // State
        reactor.state.map { $0.searchResultCellReactors }
            .distinctUntilChanged()
            .bind(to: searchResultCollectionView.rx.items(Reusable.resultCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.searchResultCellReactors.count }
            .distinctUntilChanged()
            .map { "\($0)件の動物園" }
            .bind(to: resultCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
