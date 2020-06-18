//
//  ZooAnimalViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ZooAnimalViewController: UIViewController, View, ViewConstructor {
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        title = reactor?.currentState.zoo.name
    }
    
    func setupViewConstraints() {
        
    }
    
    // MARK: - Bind Method
    func bind(reactor: ZooAnimalReactor) {
        // Action
        
        // State
    }
}
