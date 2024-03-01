//
//  TrandingViewController.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit

class TrendingViewController: BaseViewController {
    
    let trendingView = TrendingView()
    
    override func loadView() {
        self.view = trendingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingView.collectionView.delegate = self
        trendingView.collectionView.dataSource = self
        trendingView.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        trendingView.collectionView.register(FavoriteSectionCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteSectionCollectionViewCell.identifier)
    }
    
    override func configureView(navigationTitle: String) {
        super.configureView(navigationTitle: "Crypto Coin")
    }
}

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteSectionCollectionViewCell.identifier, for: indexPath) as! FavoriteSectionCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
        header.titleLabel.text = TrendingSection.allCases[indexPath.section].headerTitle
        return header
    }
}
