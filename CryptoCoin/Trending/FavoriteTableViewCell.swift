//
//  FavoriteCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/29/24.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteTableViewCell {
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (space * 3)
        let width = cellWidth / 1.8
        
        layout.itemSize = CGSize(width: width, height: 150)
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
