//
//  ContestDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/01.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SegementSlide
import ReactorKit
import RxSwift

final class ContestDetailViewController: SegementSlideDefaultViewController, View {
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let contestDetailHeader = ContestDetailHeader()
    
    // MARK: - Segement Settings
    
    override var titlesInSwitcher: [String] {
        return ["情報", "エントリー", "投稿", "結果"]
    }
    
    override func segementSlideHeaderView() -> UIView? {
        return contestDetailHeader
    }
    
    override var switcherConfig: SegementSlideDefaultSwitcherConfig {
        var config = super.switcherConfig
        config.normalTitleFont = TextStyle.font(.normalBold)()
        config.selectedTitleFont = TextStyle.font(.normalBold)()
        config.horizontalMargin = 24
        config.horizontalSpace = 24
        return config
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
        case 0:
            return ContestDetailInfoViewController().then {
                $0.reactor = ContestDetailInfoReactor(contest: TestData.contest())
            }
        case 1:
            return ContestDetailEntryViewController().then {
                $0.reactor = ContestDetailEntryReactor(contest: TestData.contest())
            }
        case 2:
            return ContestDetailPostViewController().then {
                $0.reactor = ContestDetailPostReactor(contest: TestData.contest())
            }
        default:
            return ContestDetailResultViewController().then {
                $0.reactor = ContestDetailResultReactor(contest: TestData.contest())
            }
        }
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSelectedIndex = 0
        reloadData()
    }
    
    // MARK: - Bind Method
    func bind(reactor: ContestDetailReactor) {
        contestDetailHeader.reactor = reactor
        
        // Action
        
        // State
    }
}
