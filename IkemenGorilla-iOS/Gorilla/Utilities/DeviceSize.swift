//
//  DeviceSize.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

struct DeviceSize {
    static var screenBounds: CGRect {
        return UIScreen.main.bounds
    }

    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    static func navBarHeight(_ navigationController: UINavigationController?) -> CGFloat {
        return navigationController?.navigationBar.frame.size.height ?? 0
    }

    static func tabBarHeight(_ tabBarController: UITabBarController?) -> CGFloat {
        return tabBarController?.tabBar.frame.size.height ?? 0
    }
}
