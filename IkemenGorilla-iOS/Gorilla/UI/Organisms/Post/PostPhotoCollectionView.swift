//
//  PostPhotoCollectionView.swift
//  Gorilla
//
//  Created by admin on 2020/06/26.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

class PostPhotoCollectionView: UICollectionView, View, ViewConstructor {
    struct Const {
        static let sectionHeight: CGFloat = ((DeviceSize.screenWidth - 48) / 3 + 8) * 6
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    struct Reusable {
        static let postCell = ReusableCell<PostPhotoCell>()
    }
    
    private let isCalculateHeight: Bool
    
    // MARK: - Initializers
    init(isCalculateHeight: Bool) {
        self.isCalculateHeight = isCalculateHeight
        super.init(frame: .zero, collectionViewLayout: PostPhotoCollectionView.createLayout())
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Setup Methods
    func setupViews() {
        register(Reusable.postCell)
        backgroundColor = Color.white
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentInset.bottom = 16
        showsVerticalScrollIndicator = false
    }
    
    func setupViewConstraints() {}
    
    static func createLayout() -> UICollectionViewLayout {
        let sideInset: CGFloat = 16
        let insideInset: CGFloat = 8
        let topInset: CGFloat = 8
        let viewWidth: CGFloat = DeviceSize.screenWidth
        let smallSquareWidth: CGFloat = (viewWidth - (sideInset * 2 + insideInset * 2)) / 3
        let mediumSquareWidth: CGFloat = smallSquareWidth * 2 + insideInset
        let nestedGroupHeight: CGFloat = mediumSquareWidth + topInset
        let smallSquareGroupHeight: CGFloat = smallSquareWidth + topInset
        
        
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let nestedGroupTypeA: NSCollectionLayoutGroup = {
                let smallSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(smallSquareWidth + insideInset)))
                smallSquareItem.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: insideInset)
                let smallSquareGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(smallSquareWidth + insideInset),
                                                      heightDimension: .fractionalHeight(1.0)),
                    subitem: smallSquareItem, count: 2)

                let mediumSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(mediumSquareWidth),
                                                      heightDimension: .fractionalHeight(1.0)))
                mediumSquareItem.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: 0)

                let nestedGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(nestedGroupHeight)),
                    subitems: [smallSquareGroup, mediumSquareItem])
                return nestedGroup
            }()
            
            let nestedGroupTypeB: NSCollectionLayoutGroup = {
                let mediumSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(mediumSquareWidth + insideInset),
                                                      heightDimension: .fractionalHeight(1.0)))
                mediumSquareItem.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: insideInset)

                let smallSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(smallSquareWidth + insideInset)))
                smallSquareItem.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: 0)
                let smallSquareGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(smallSquareWidth),
                                                      heightDimension: .fractionalHeight(1.0)),
                    subitem: smallSquareItem, count: 2)

                let nestedGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(nestedGroupHeight)),
                    subitems: [mediumSquareItem, smallSquareGroup])
                return nestedGroup
            }()
            
            let nestedGroupTypeC: NSCollectionLayoutGroup = {
                let smallSquareItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(smallSquareWidth),
                                                      heightDimension: .fractionalHeight(1.0)))

                let smallSquareGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(smallSquareGroupHeight)),
                    subitem: smallSquareItem,
                    count: 3)
                smallSquareGroup.interItemSpacing = .fixed(insideInset)
                smallSquareGroup.contentInsets = NSDirectionalEdgeInsets(top: topInset, leading: 0, bottom: 0, trailing: 0)
                
                return smallSquareGroup
            }()
            
            let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(nestedGroupHeight * 2 + smallSquareGroupHeight * 2)),
            subitems: [nestedGroupTypeA, nestedGroupTypeC, nestedGroupTypeB, nestedGroupTypeC])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sideInset, bottom: 0, trailing: sideInset)
            return section

        }
        return layout
    }
    
    // MARK: - Bind Method
    func bind(reactor: PostPhotoCollectionReactor) {
        // Action
        
        // State
        reactor.state.map { $0.postCellReactors }
            .distinctUntilChanged()
            .bind(to: rx.items(Reusable.postCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.postCellReactors.count }
            .distinctUntilChanged()
            .bind { [weak self] count in
                if self?.isCalculateHeight ?? false {
                    self?.removeConstraints(self?.constraints ?? [])
                    self?.snp.makeConstraints {
                        $0.height.equalTo(self?.viewHeight(count: count) ?? 0)
                        $0.width.equalTo(DeviceSize.screenWidth)
                    }
                } else {
                    self?.contentSize.height = self?.viewHeight(count: count) ?? 0
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func viewHeight(count: Int) -> CGFloat {
        let topMargin: CGFloat = 16
        let rowHeight: CGFloat = (DeviceSize.screenWidth - 48) / 3 + 8
        let sectionCount = count / 12
        var bodyHeight: CGFloat = 0
        switch count % 12 {
        case 0:
            bodyHeight = 0
        case 1:
            bodyHeight = rowHeight
        case 2, 3:
            bodyHeight = rowHeight * 2
        case 4, 5, 6:
            bodyHeight = rowHeight * 3
        case 7, 8, 9:
            bodyHeight = rowHeight * 5
        case 10, 11:
            bodyHeight = 0
        default:
            break
        }
        return topMargin + bodyHeight + CGFloat(sectionCount) * Const.sectionHeight
    }
}
