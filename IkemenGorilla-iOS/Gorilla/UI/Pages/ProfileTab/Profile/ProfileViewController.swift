//
//  ProfileViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/04.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class ProfileViewController: UIViewController, View, ViewConstructor, TransitionPresentable {
    
    struct Const {
        static let scrollViewContentInset = UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    private lazy var profileCurrentContestListCallback = ProfileCurrentContestListView.Callback(itemSelected: { contest in
        guard let reactor = self.reactor else { return }
        self.showContestDetailPage(contestDetailReactor: reactor.createProfileContestDetailReactor(contest: contest))
    })
    
    // MARK: - Views
    
    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let profileInfoHeader = ProfileInfoHeader()
    
    private lazy var profileInfoListView = ProfileInfoListView().then {
        $0.reactor = reactor?.createProfileInfoListReactor()
    }
    
    private let profileCurrentContestHeader = ProfileCurrentContestHeader()
    
    private lazy var profileCurrentContestListView = ProfileCurrentContestListView(callback: profileCurrentContestListCallback).then {
        $0.reactor = reactor?.createProfileCurrentContestListReactor()
    }
    
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    
    func setupViews() {
        scrollView.contentInset = Const.scrollViewContentInset
        view.addSubview(stackView)
        stackView.addArrangedSubview(profileInfoHeader)
        stackView.addArrangedSubview(profileInfoListView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(profileCurrentContestHeader)
        stackView.addArrangedSubview(profileCurrentContestListView)
        stackView.setCustomSpacing(36, after: profileCurrentContestListView)

    }
    
    func setupViewConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
        }
    }
    
    // MARK: - Bind Method
   func bind(reactor: ProfileReactor) {
       // Action
       
       // State
   }
}
