//
//  FavoriteView.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import UIKit

class FavoriteView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureView() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Design.Color.customPurple.fill
        collectionView.refreshControl = refreshControl
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 16
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (space * 3)
        
        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/2)
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        
        return layout
    }
}
