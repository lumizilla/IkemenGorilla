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

final class MapSearchViewController: UIViewController, View, ViewConstructor {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let searchBar = UISearchBar().then {
        $0.placeholder = "動物園、住所"
        $0.backgroundImage = UIImage()
        $0.tintColor = Color.black
        $0.showsCancelButton = true
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
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
    func setupViewConstraints() {
        
    }
    
    // MARK: - Bind Method
    func bind(reactor: MapSearchReactor) {
        // Action
        searchBar.rx.cancelButtonClicked
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        // State
    }
}
