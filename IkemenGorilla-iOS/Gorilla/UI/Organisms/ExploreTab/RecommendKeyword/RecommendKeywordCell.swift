//
//  RecommendKeywordCell.swift
//  Gorilla
//
//  Created by admin on 2020/07/18.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift

final class RecommendKeywordCell: UITableViewCell, View, ViewConstructor {
    
    private struct Const {
        static let circleRadius: CGFloat = 22
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let circleView = UIView().then {
        $0.layer.cornerRadius = Const.circleRadius
        $0.layer.masksToBounds = true
        $0.layer.borderColor = Color.black.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    private let searchIconView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "search_empty").withRenderingMode(.alwaysTemplate)
        $0.tintColor = Color.black
        $0.contentMode = .scaleAspectFit
    }
    
    private let wordLabel = UILabel().then {
        $0.apply(fontStyle: .medium, size: 13)
        $0.textColor = Color.textBlack
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        contentView.addSubview(circleView)
        contentView.addSubview(searchIconView)
        contentView.addSubview(wordLabel)
    }
    
    func setupViewConstraints() {
        circleView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.left.equalToSuperview().inset(16)
            $0.size.equalTo(Const.circleRadius*2)
            $0.bottom.equalToSuperview().inset(8)
        }
        searchIconView.snp.makeConstraints {
            $0.center.equalTo(circleView)
        }
        wordLabel.snp.makeConstraints {
            $0.left.equalTo(circleView.snp.right).offset(12)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Bind Method
    func bind(reactor: RecommendKeywordCellReactor) {
        // Action
        
        // State
        reactor.state.map { $0.keyword }
            .distinctUntilChanged()
            .bind(to: wordLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
}
