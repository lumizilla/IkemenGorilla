//
//  CreateVoteViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/28.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class CreateVoteViewController: UIViewController, View, ViewConstructor {
    
    struct Const {
        static let height: CGFloat = 316
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(imageView)
    }
    
    func setupViewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.left.equalToSuperview().inset(16)
            $0.width.equalTo(176)
            $0.height.equalTo(156)
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: VoteContestDetailReactor) {
        // Action
        
        // State
        reactor.state.map { $0.voteEntry?.iconUrl }
            .distinctUntilChanged()
            .bind { [weak self] iconUrl in
                guard let iconUrl = iconUrl else { return }
                self?.imageView.setImage(imageUrl: iconUrl)
            }
            .disposed(by: disposeBag)
    }
}
