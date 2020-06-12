//
//  ContestAnimalDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/12.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import ReusableKit

final class ContestAnimalDetailViewController: UIViewController, View, ViewConstructor {
    struct Reusable {
        static let postCell = ReusableCell<ContestAnimalDetailPostCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private lazy var postsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(Reusable.postCell)
        $0.backgroundColor = Color.white
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.contentInset.bottom = 16
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewConstraints()
    }
    
    // MARK: - Setup Methods
    func setupViews() {
        view.addSubview(postsCollectionView)
    }
    
    func setupViewConstraints() {
        postsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
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
    func bind(reactor: ContestAnimalDetailReactor) {
        // Action
        reactor.action.onNext(.load)
        
        // State
        reactor.state.map { $0.postCellReactors }
            .distinctUntilChanged()
            .bind(to: postsCollectionView.rx.items(Reusable.postCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
    }
}
