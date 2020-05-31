//
//  TransitionPresentable.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol TransitionPresentable: class {
    // HOME TAB
    func showHomePastContestPage(homePastContestReactor: HomePastContestReactor)
    func showHomeRecommendedZooPage(homeRecommendedZooReactor: HomeRecommendedZooReactor)
}

extension TransitionPresentable where Self: UIViewController {
    // HOME TAB
    func showHomePastContestPage(homePastContestReactor: HomePastContestReactor) {
        navigationController?.pushViewController(
            HomePastContestViewController().then {
                $0.reactor = homePastContestReactor
                
            },
            animated: true
        )
    }
    
    func showHomeRecommendedZooPage(homeRecommendedZooReactor: HomeRecommendedZooReactor) {
        navigationController?.pushViewController(
            HomeRecommendedZooViewController().then {
                $0.reactor = homeRecommendedZooReactor
            },
            animated: true
        )
    }
}
