//
//  DevelopingViewController.swift
//  Gorilla
//
//  Created by admin on 2020/05/24.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SnapKit
import Then

// Free to use to test your layout or something else ...
final class DevelopingViewController: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.text = "Developing ViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
