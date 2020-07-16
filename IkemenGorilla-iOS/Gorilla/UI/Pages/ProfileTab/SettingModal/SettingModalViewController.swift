//
//  SettingModalViewController.swift
//  Gorilla
//
//  Created by admin on 2020/07/09.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import PanModal

protocol SettingModalViewControllerDelegate {
    func didTapHerokuAPI()
}

final class SettingModalViewController: UIViewController, ViewConstructor {
    
    let indicator = UIView().then {
        $0.backgroundColor = Color.lightGray
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 2
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    let postmanAPICell = SettingModalCell(type: .postmanAPI)
    let herokuAPICell = SettingModalCell(type: .herokuAPI)
    
    var delegate: SettingModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = Color.white
        
        view.addSubview(indicator)
        
        herokuAPICell.addTarget(self, action: #selector(didTapHerokuAPI), for: .touchUpInside)
        
        stackView.addArrangedSubview(postmanAPICell)
        stackView.addArrangedSubview(herokuAPICell)
        view.addSubview(stackView)
    }
    
    func setupViewConstraints() {
        indicator.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(36)
            $0.height.equalTo(4)
        }
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.left.right.equalToSuperview()
        }
    }
    
    @objc func didTapHerokuAPI() {
        dismiss(animated: true, completion: {
            self.delegate?.didTapHerokuAPI()
        })
    }
}

extension SettingModalViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(
            CGFloat(56 * 3 + 26)
        )
    }

    var longFormHeight: PanModalHeight {
        return shortFormHeight
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.6)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var showDragIndicator: Bool {
        return false
    }
}
