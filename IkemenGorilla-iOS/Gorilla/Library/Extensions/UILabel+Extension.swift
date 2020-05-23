//
//  UILabel+Extension.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(textStyle: TextStyle) {
        self.init(frame: .zero)
        self.font = textStyle.font()
        textColor = Color.textBlack
    }
    
    func apply(textStyle: TextStyle, color: UIColor = Color.textBlack) {
        font = textStyle.font()
        textColor = color
    }
    
    func apply(fontStyle: FontStyle, size: CGFloat, color: UIColor = Color.textBlack) {
        font = UIFont(name: fontStyle.rawValue, size: size)
        textColor = color
    }
}
