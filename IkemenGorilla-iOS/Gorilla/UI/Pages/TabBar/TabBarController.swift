//
//  TabBarController.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//


import UIKit

class TabBarController: UITabBarController {
    private struct Const {
        static let tabBarImages: [UIImage] = [#imageLiteral(resourceName: "home_empty"), #imageLiteral(resourceName: "map_empty"), #imageLiteral(resourceName: "plus_empty"), #imageLiteral(resourceName: "search_empty"), #imageLiteral(resourceName: "user_empty")]
        static let tabBarSelectedImages: [UIImage] = [#imageLiteral(resourceName: "home_filled"), #imageLiteral(resourceName: "map_filled"), #imageLiteral(resourceName: "plus_filled"), #imageLiteral(resourceName: "search_filled"), #imageLiteral(resourceName: "user_filled")]
    }
    
//    private let provider: ServiceProviderType
    
//    init(provider: ServiceProviderType) {
//        self.provider = provider
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        delegate = self
    }

    // MARK: - Setup Methods
    private func setupViewControllers() {
        viewControllers = [
            UINavigationController(rootViewController: HomeViewController().then {
                $0.reactor = HomeReactor()
            }),
            UINavigationController(rootViewController: DevelopingViewController(type: "Map")),
            DevelopingViewController(type: "Vote"),
            UINavigationController(rootViewController: DevelopingViewController(type: "Search")),
            //UINavigationController(rootViewController: FrontendEchoViewController().then {
            //    $0.reactor = FrontendEchoReactor()
            //}),
            UINavigationController(rootViewController: ProfileViewController().then {
                $0.reactor = ProfileReactor()
            }),
        ]

        tabBar.do {
            $0.isTranslucent = false
            $0.backgroundColor = Color.lightGray
            $0.tintColor = Color.textBlack
            $0.unselectedItemTintColor = Color.textGray
            $0.items?.enumerated().forEach { index, tabBarItem in
                tabBarItem.image = Const.tabBarImages[index]
                tabBarItem.selectedImage = Const.tabBarSelectedImages[index]
                tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
        }
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is DummyViewController {
//            showReportCreatePage(reportCreateReactor: ReportCreateReactor(provider: provider))
            return false
        }
        return true
    }
}

class DummyViewController: UIViewController {}
