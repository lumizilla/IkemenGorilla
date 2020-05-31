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
    func showHomeRecommendedZooPage(recommendedZooReactor: RecommendedZooReactor)
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
    
    func showHomeRecommendedZooPage(recommendedZooReactor: RecommendedZooReactor) {
        navigationController?.pushViewController(
            HomeRecommendedZooViewController().then {
                $0.reactor = recommendedZooReactor
            },
            animated: true
        )
    }
}
