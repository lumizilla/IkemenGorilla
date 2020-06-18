//
//  ZooDetailViewController.swift
//  Gorilla
//
//  Created by admin on 2020/06/18.
//  Copyright © 2020 admin. All rights reserved.
//

import ReactorKit
import RxSwift
import ReusableKit

final class ZooDetailViewController: UIViewController, View, ViewConstructor {
    struct Const {
        static let sectionHeight: CGFloat = ((DeviceSize.screenWidth - 48) / 3 + 8) * 6
    }
    
    struct Reusable {
        static let animalCell = ReusableCell<ZooDetailAnimalCell>()
        static let postCell = ReusableCell<ZooDetailPostCell>()
    }
    
    // MARK: - Variables
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    private let contentScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.alwaysBounceVertical = true
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let header = ZooDetailHeader()
    
    private let animalsHeader = ZooDetailAnimalsHeader()
    
    private let animalsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.itemSize = ZooDetailAnimalCell.Const.itemSize
        $0.minimumLineSpacing = 16
        $0.scrollDirection = .horizontal
    }).then {
        $0.register(Reusable.animalCell)
        $0.backgroundColor = Color.white
        $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let postsHeader = ZooDetailPostsHeader()
    
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
        view.backgroundColor = Color.white
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(stackView)
        stackView.addArrangedSubview(header)
        stackView.addArrangedSubview(animalsHeader)
        stackView.addArrangedSubview(animalsCollectionView)
        stackView.addArrangedSubview(postsHeader)
        stackView.addArrangedSubview(postsCollectionView)
    }
    
    func setupViewConstraints() {
        contentScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        header.snp.makeConstraints {
            $0.width.equalTo(DeviceSize.screenWidth)
        }
        animalsCollectionView.snp.makeConstraints {
            $0.width.equalTo(DeviceSize.screenWidth)
            $0.height.equalTo(96)
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
    func bind(reactor: ZooDetailReactor) {
        header.reactor = reactor
        // Action
        reactor.action.onNext(.loadAnimals)
        reactor.action.onNext(.loadPosts)
        
        // State
        reactor.state.map { $0.animalCellReactors }
            .distinctUntilChanged()
            .bind(to: animalsCollectionView.rx.items(Reusable.animalCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.postCellReactors }
            .distinctUntilChanged()
            .bind(to: postsCollectionView.rx.items(Reusable.postCell)) { _, reactor, cell in
                cell.reactor = reactor
            }
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.postCellReactors.count / 12 }
            .distinctUntilChanged()
            .bind { [weak self] sectionCount in
                self?.stackView.removeConstraints(self?.postsCollectionView.constraints ?? [])
                self?.postsCollectionView.snp.makeConstraints {
                    $0.height.equalTo(16 + Const.sectionHeight * CGFloat(sectionCount))
                    $0.width.equalTo(DeviceSize.screenWidth)
                }
            }
            .disposed(by: disposeBag)
    }
}
