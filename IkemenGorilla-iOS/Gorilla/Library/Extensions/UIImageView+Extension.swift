//
//  UIImageView+Extension.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String, placeholder: UIImage = #imageLiteral(resourceName: "loading")) {
        guard let url = URL(string: imageUrl) else {
            self.image = placeholder
            return
        }
        
        kf.setImage(with: url, placeholder: placeholder)
    }
}
