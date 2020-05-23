//
//  TextStyle.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import  UIKit

enum FontStyle: String {
    case black = "NotoSansCJKjp-Black"
    case bold = "NotoSansCJKjp-Bold"
    case regular = "NotoSansCJKjp-Regular"
    case medium = "NotoSansCJKjp-Medium"
}

enum TextStyle: Int {
    case huge
    case title
    case subTitle
    case large
    case normalBold
    case normalRegular
    case small
    case tiny
    
    func size() -> CGFloat {
        switch self {
        case .huge:
            return 32
        case .title:
            return 24
        case .subTitle:
            return 16
        case .large:
            return 15
        case .normalBold:
            return 13
        case .normalRegular:
            return 13
        case .small:
            return 12
        case .tiny:
            return 11
        }
    }
    
    func fontStyle() -> FontStyle {
        switch self {
        case .huge:
            return .black
        case .title:
            return .black
        case .subTitle:
            return .black
        case .large:
            return .bold
        case .normalBold:
            return .bold
        case .normalRegular:
            return .regular
        case .small:
            return .bold
        case .tiny:
            return .regular
        }
    }

    func font() -> UIFont {
        return UIFont(name: fontStyle().rawValue, size: size()) ?? undefined("TextStyle: Font not exist")
    }
}
