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
    func showHomePastContestPage(pastContestReactor: PastContestReactor)
    func showRecommendedZooPage(recommendedZooReactor: RecommendedZooReactor)
}

extension TransitionPresentable where Self: UIViewController {
    // HOME TAB
    func showHomePastContestPage(pastContestReactor: PastContestReactor) {
        navigationController?.pushViewController(
            HomePastContestViewController().then {
                $0.reactor = pastContestReactor
                
            },
            animated: true
        )
    }
    
    func showRecommendedZooPage(recommendedZooReactor: RecommendedZooReactor) {
        navigationController?.pushViewController(
            RecommendedZooViewController().then {
                $0.reactor = recommendedZooReactor
            },
            animated: true
        )
    }
}
