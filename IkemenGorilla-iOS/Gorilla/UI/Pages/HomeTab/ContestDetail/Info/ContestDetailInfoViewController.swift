//
//  ContestDetailInfoViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SegementSlide
import ReactorKit
import RxSwift

final class ContestDetailInfoViewController: UIViewController, View, ViewConstructor, SegementSlideContentScrollViewDelegate {
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    @objc var scrollView: UIScrollView {
        return contentScrollView
    }
    
    // MARK: - Views
    private let contentScrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
    }
    
    private let catchCopyLabel = UILabel().then {
        $0.text = "ワイが一番イケメンやで"
        $0.apply(fontStyle: .medium, size: 20)
        $0.textColor = Color.black
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
        contentScrollView.addSubview(catchCopyLabel)
    }
    
    func setupViewConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        catchCopyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailInfoReactor) {
        // Action
        
        // State
    }
}
