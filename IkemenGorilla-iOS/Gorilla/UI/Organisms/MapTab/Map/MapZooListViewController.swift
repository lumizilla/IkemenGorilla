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

final class MapZooListViewController: UIViewController, View, ViewConstructor {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        
    }
    
    func setupViewConstraints() {
        
    }
    
    // MARK: - Bind Method
    func bind(reactor: MapReactor) {
        // Action
        
        // State
    }
}
