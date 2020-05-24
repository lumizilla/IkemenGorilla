//
//  IconView.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class IconView: UIImageView {
    enum IconType: String {
        
        case homeFilled = "home_filled"
        case homeEmpty = "home_empty"
        case mapFilled = "map_filled"
        case mapEmpty = "map_empty"
        case plusFilled = "plus_filled"
        case plusEmpty = "plus_empty"
        case searchFilled = "search_filled"
        case searchEmpty = "search_empty"
        case userFilled = "user_filled"
        case userEmpty = "user_empty"
        case loading = "loading"
        
        func image() -> UIImage {
            return UIImage(named: self.rawValue) ?? undefined("no image name in assets")
        }
    }
    
    init(iconType: IconType ) {
        super.init(frame: .zero)
        image = UIImage(named: iconType.rawValue)
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
