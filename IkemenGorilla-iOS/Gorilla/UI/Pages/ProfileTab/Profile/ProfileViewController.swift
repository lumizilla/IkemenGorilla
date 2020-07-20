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
import PanModal
import ReusableKit

final class ProfileViewController: UIViewController, View, ViewConstructor, TransitionPresentable {
    
    struct Const {
        static let scrollViewContentInset = UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    private lazy var profileVotedContestListCallback = ProfileVotedContestListView.Callback(itemSelected: { contest in
        guard let reactor = self.reactor else { return }
        self.showVotedDetailPage(profileContestDetailReactor: reactor.createProfileContestDetailReactor(contest: contest))
    })
    
    private lazy var profileFanAnimalListCallback = ProfileFanAnimalListView.Callback(itemSelected: { fanAnimal in
        guard let reactor = self.reactor else { return }
        self.showAnimalDetailPage(animalDetailReactor: reactor.createAnimalDetailReactor(fanAnimal: fanAnimal))
    })
    
    struct Reusable {
        static let animalCell = ReusableCell<ProfileFanAnimalListCell>()
    }
    
    // MARK: - Views
    
    private let gearButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "gear"), for: .normal)
        $0.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
    }
    
    private let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private lazy var profileInfoDetail = ProfileInfoDetail().then {
        $0.reactor = reactor?.createProfileInfoDetailReactor()
    }
    
    private let profileFanAnimalHeader = ProfileFanAnimalHeader()
    
    private lazy var profileFanAnimalListView = ProfileFanAnimalListView(callback: profileFanAnimalListCallback).then {
        $0.reactor = reactor?.createProfileFanAnimalListReactor()
    }
    
    private let profileVotedContestHeader = ProfileVotedContestHeader()
    
    private lazy var profileVotedContestListView = ProfileVotedContestListView(callback: profileVotedContestListCallback).then {
        $0.reactor = reactor?.createProfileVotedContestListReactor()
    }
    
    private let likedZooHeader = ProfileLikedZooHeader()
    
    private lazy var likedZooListView = ProfileLikedZooListView().then {
        $0.reactor = reactor?.createProfileLikedZooListReactor()
    }

    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    
    func setupViews() {
        title = "プロフィール"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: gearButton)
        scrollView.contentInset = Const.scrollViewContentInset
        view.addSubview(stackView)
        stackView.addArrangedSubview(profileInfoDetail)
        stackView.setCustomSpacing(130, after: profileInfoDetail)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(profileFanAnimalHeader)
        stackView.addArrangedSubview(profileFanAnimalListView)
        stackView.setCustomSpacing(36, after: profileFanAnimalListView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(profileVotedContestHeader)
        stackView.addArrangedSubview(profileVotedContestListView)
        stackView.setCustomSpacing(36, after: profileVotedContestListView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(likedZooHeader)
        stackView.addArrangedSubview(likedZooListView)
        stackView.setCustomSpacing(36, after: likedZooListView)
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
       profileFanAnimalHeader.showAllButton.rx.tap
       .bind { [weak self] _ in
            logger.debug("tap show all fans button")
            let vc = FanAnimalViewController().then {
                $0.reactor = reactor.createFanAnimalReactor()
            }
            self?.navigationController?.pushViewController(vc, animated: true)
       }
       .disposed(by: disposeBag)
    
       profileVotedContestHeader.showAllButton.rx.tap
       .bind { [weak self] _ in
           self?.showVotedContestPage(votedContestReactor: reactor.createVotedContestReactor())
       }
       .disposed(by: disposeBag)
    
       likedZooHeader.showAllButton.rx.tap
           .bind { [weak self] _ in
               self?.showLikedZooPage(likedZooReactor: reactor.createLikedZooReactor())
           }
           .disposed(by: disposeBag)
       
       likedZooListView.rx.itemSelected
           .bind { [weak self] indexPath in
               guard let reactor = self?.likedZooListView.reactor?.createZooDetailReactor(indexPath: indexPath) else { return }
               self?.showZooDetailPage(zooDetailReactor: reactor)
           }
           .disposed(by: disposeBag)
    
        gearButton.rx.tap
            .bind { [weak self] _ in
                logger.debug("gear button tapped")
                let vc = SettingModalViewController()
                vc.delegate = self
                self?.presentPanModal(vc)
            }
            .disposed(by: disposeBag)
    
       // State
   }
}

extension ProfileViewController: SettingModalViewControllerDelegate {
    func didTapHerokuAPI() {
        logger.debug("didtap from profileviewcontroller")
    }
}
