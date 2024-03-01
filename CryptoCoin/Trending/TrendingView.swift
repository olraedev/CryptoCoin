//
//  TrendingView.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/29/24.
//

import UIKit
import SnapKit

class TrendingView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.compositionalLayout)
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
            UICollectionViewCompositionalLayout { [unowned self] sectionIndex, env in
                switch TrendingSection(rawValue: sectionIndex) {
                case .favorite:
                    return favoriteLayout()
                case .top15Coin:
                    return rankLayout()
                case .top7NFT:
                    return rankLayout()
                case .none: return nil
                }
            }
        }()
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension TrendingView {
    private func favoriteLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.7), heightDimension: .estimated(180)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        return section
    }
    
    private func rankLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(240)), subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)]
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 8)
        return section
    }
}
