//
//  VoteButton.swift
//  Gorilla
//
//  Created by admin on 2020/06/12.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class VoteButton: UIButton, ViewConstructor {
    // MARK: - Variables
    var isVoted: Bool = false {
        didSet {
            setStyle(isVoted: isVoted)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            shrink(down: isHighlighted)
        }
    }
    
    private let gradientLayer = CAGradientLayer().then {
        $0.colors = [Color.teal.cgColor, Color.teal.cgColor]
        $0.startPoint = CGPoint(x: 0, y: 0)
        $0.endPoint = CGPoint(x: 1, y: 0)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.bounds
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        titleLabel?.apply(fontStyle: .bold, size: 15)
        isVoted = false
        titleLabel?.textAlignment = .center
        layer.masksToBounds = true
        layer.cornerRadius = 4
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setupViewConstraints() {}
    
    func setStyle(isVoted: Bool) {
        if isVoted {
            setTitle("応募しました", for: .normal)
            setTitleColor(Color.textBlack, for: .normal)
            backgroundColor = Color.borderGray
        } else {
            setTitle("応募する", for: .normal)
            setTitleColor(Color.white, for: .normal)
        }
        gradientLayer.isHidden = isVoted
    }
    
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

extension Reactive where Base: VoteButton {
    var isApplied: Binder<Bool> {
        return Binder(base) { view, isApplied in
            view.isVoted = isApplied
        }
    }
}
