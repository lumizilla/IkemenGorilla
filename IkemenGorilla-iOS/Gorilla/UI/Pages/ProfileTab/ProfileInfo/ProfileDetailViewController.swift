//
//  ProfileDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/07/17.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class ProfileDetailViewController: UIViewController, View, ViewConstructor {
    
    struct Const {
        static let cellWidth: CGFloat = DeviceSize.screenWidth
        static let cellHeight: CGFloat = 400
        static let itemSize: CGSize = CGSize(width: cellWidth, height: cellHeight)
        static let imageViewSize: CGSize = CGSize(width: 80, height: 80)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let header = ProfileInfoDetail()
    
    // MARK: - Lify Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.backgroundColor = Color.white
        view.addSubview(header)
        title = "プロフィール"
    }
    
    func setupViewConstraints() {
        header.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Const.cellHeight)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: ProfileDetailReactor) {
        header.reactor = reactor
        
        // Action
        reactor.action.onNext(.loadUserDetail)
        
        // State
    }
}
