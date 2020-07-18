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
    func showPastContestPage(pastContestReactor: PastContestReactor)
    func showRecommendedZooPage(recommendedZooReactor: RecommendedZooReactor)
    func showContestDetailPage(contestDetailReactor: ContestDetailReactor)
    func showContestAnimalDetailPage(contestAnimalDetailReactor: ContestAnimalDetailReactor)
    
    // MAP TAB
    func showZooDetailPage(zooDetailReactor: ZooDetailReactor)
    func showAnimalDetailPage(animalDetailReactor: AnimalDetailReactor)
    func showMapSearchPage(mapSearchReactor: MapSearchReactor)
    
    // VOTE TAB
    func showVoteContestPage(voteContestReactor: VoteContestReactor)
    func showVoteContestDetailPage(voteContestDetailReactor: VoteContestDetailReactor)
    
    // EXPLORE TAB
    func showExplorePostDetailPage(explorePostDetailReactor: ExplorePostDetailReactor)
    func showExploreSearchResultPage(exploreSearchResultReactor: ExploreSearchResultReactor)
}

extension TransitionPresentable where Self: UIViewController {
    // HOME TAB
    func showPastContestPage(pastContestReactor: PastContestReactor) {
        navigationController?.pushViewController(
            PastContestViewController().then {
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
    
    func showContestDetailPage(contestDetailReactor: ContestDetailReactor) {
        navigationController?.pushViewController(
            ContestDetailViewController().then {
                $0.reactor = contestDetailReactor
            },
            animated: true
        )
    }
    
    func showContestAnimalDetailPage(contestAnimalDetailReactor: ContestAnimalDetailReactor) {
        navigationController?.pushViewController(
            ContestAnimalDetailViewController().then {
                $0.reactor = contestAnimalDetailReactor
            },
            animated: true
        )
    }

    func showVotedDetailPage(votedContestReactor: VotedContestReactor) {
        navigationController?.pushViewController(
            VotedContestViewController().then {
                $0.reactor = votedContestReactor
            },
            animated: true
        )
    }
    

    // MAP TAB
    func showZooDetailPage(zooDetailReactor: ZooDetailReactor) {
        navigationController?.pushViewController(
            ZooDetailViewController().then {
                $0.reactor = zooDetailReactor
            },
            animated: true
        )
    }
    
    func showAnimalDetailPage(animalDetailReactor: AnimalDetailReactor) {
        navigationController?.pushViewController(
            AnimalDetailViewController().then {
                $0.reactor = animalDetailReactor
            },
            animated: true
        )
    }

    func showFanAnimalPage(fanAnimalReactor: FanAnimalReactor) {
        navigationController?.pushViewController(
            FanAnimalViewController().then {
                $0.reactor = fanAnimalReactor
            },
            animated: true
        )
    }
    
    func showMapSearchPage(mapSearchReactor: MapSearchReactor) {
        present(
            UINavigationController(rootViewController:
                MapSearchViewController().then {
                    $0.reactor = mapSearchReactor
                }
            ).then {
                $0.modalPresentationStyle = .fullScreen
            },
            animated: true,
            completion: nil
        )
    }
    
    // VOTE TAB
    func showVoteContestPage(voteContestReactor: VoteContestReactor) {
        present(
            UINavigationController(
                rootViewController: VoteContestViewController().then {
                    $0.reactor = voteContestReactor
                }
            ).then {
                $0.modalPresentationStyle = .fullScreen
            },
            animated: true,
            completion: nil
        )
    }
    
    func showVoteContestDetailPage(voteContestDetailReactor: VoteContestDetailReactor) {
        navigationController?.pushViewController(
            VoteContestDetailViewController().then {
                $0.reactor = voteContestDetailReactor
            },
            animated: true
        )
    }
    
    // EXPLORE TAB
    func showExplorePostDetailPage(explorePostDetailReactor: ExplorePostDetailReactor) {
        navigationController?.pushViewController(
            ExplorePostDetailViewController().then {
                $0.reactor = explorePostDetailReactor
            },
            animated: true
        )
    }
    
    func showExploreSearchResultPage(exploreSearchResultReactor: ExploreSearchResultReactor) {
        navigationController?.pushViewController(
            ExploreSearchResultViewController().then {
                $0.reactor = exploreSearchResultReactor
            },
            animated: true
        )
    }
    
    // PROFILE TAB
    func showProfileInfoPage(profileInfoReactor: ProfileInfoReactor) {
        navigationController?.pushViewController(
            ProfileInfoViewController().then {
                $0.reactor = profileInfoReactor
            },
            animated: true
        )
    }
    
    func showLikedZooPage(likedZooReactor: LikedZooReactor) {
        navigationController?.pushViewController(
            LikedZooViewController().then {
                $0.reactor = likedZooReactor
            },
            animated: true
        )
    }
}
