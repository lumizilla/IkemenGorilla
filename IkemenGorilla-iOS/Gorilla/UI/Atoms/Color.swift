//
//  Color.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

struct Color {
    private init() {}

    static var white: UIColor {
        return UIColor(hex: "FFFFFF")
    }

    static var black: UIColor {
        return UIColor(hex: "333333")
    }

    static var textBlack: UIColor {
        return UIColor(hex: "4F4F4F")
    }

    static var textGray: UIColor {
        return UIColor(hex: "828282")
    }

    static var gray: UIColor {
        return UIColor(hex: "BDBDBD")
    }

    static var lightGray: UIColor {
        return UIColor(hex: "E0E0E0")
    }

    static var borderGray: UIColor {
        return UIColor(hex: "F2F2F2")
    }

    static var teal: UIColor {
        return UIColor(hex: "1F9198")
    }
    
    static var red: UIColor {
        return UIColor(hex: "EB5757")
    }
}
