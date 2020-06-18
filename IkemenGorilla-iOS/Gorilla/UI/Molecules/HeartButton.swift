//
//  HeartButton.swift
//  Gorilla
//
//  Created by admin on 2020/06/19.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class HeartButton: UIButton, ViewConstructor {
    // MARK: - Variables
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        backgroundColor = Color.white
        setImage(#imageLiteral(resourceName: "heart_empty").withRenderingMode(.alwaysTemplate), for: .normal)
        setImage(#imageLiteral(resourceName: "heart_filled").withRenderingMode(.alwaysTemplate), for: .selected)
        tintColor = Color.red
        
        layer.cornerRadius = 32
        
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowColor = Color.black.cgColor
        layer.shadowOpacity = 0.5
    }
    
    func setupViewConstraints() {}
    
    func shrink(down: Bool) {
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: [.allowUserInteraction],
                       animations: {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } else {
                self.transform = .identity
            }
        },
        completion: nil)
    }
}
