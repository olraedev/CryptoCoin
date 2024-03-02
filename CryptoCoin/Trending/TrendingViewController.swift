//
//  TrandingViewController.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit

class TrendingViewController: BaseViewController {
    
    let trendingView = TrendingView()
    let viewModel = TrendingViewModel()
    
    override func loadView() {
        self.view = trendingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    override func configureView(navigationTitle: String) {
        super.configureView(navigationTitle: "Crypto Coin")
        
        trendingView.collectionView.delegate = self
        trendingView.collectionView.dataSource = self
        trendingView.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        trendingView.collectionView.register(FavoriteSectionCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteSectionCollectionViewCell.identifier)
        trendingView.collectionView.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.identifier)
        trendingView.collectionView.register(MoreCollectionViewCell.self, forCellWithReuseIdentifier: MoreCollectionViewCell.identifier)
    }
}

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
        header.titleLabel.text = TrendingSection.allCases[indexPath.section].headerTitle
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TrendingSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch TrendingSection(rawValue: section) {
        case .favorite:
            let favoriteListCount = viewModel.outputFavoriteList.value.count
            if favoriteListCount < 2 { return 0 }
            else if 2 <= favoriteListCount && favoriteListCount < 4  {
                return favoriteListCount
            }
            else { return 4 }
        case .top15Coin: return viewModel.outputCoinRankList.value.count
        case .top7NFT: return viewModel.outputNftRankList.value.count
        case .none: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch TrendingSection(rawValue: indexPath.section) {
        case .favorite:
            if indexPath.item < 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteSectionCollectionViewCell.identifier, for: indexPath) as! FavoriteSectionCollectionViewCell
                cell.configureCell(viewModel.outputFavoriteList.value[indexPath.item])
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreCollectionViewCell.identifier, for: indexPath) as! MoreCollectionViewCell
                return cell
            }
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankCollectionViewCell.identifier, for: indexPath) as! RankCollectionViewCell
            
            if indexPath.section == 1 {
                cell.configureCoinCell(viewModel.outputCoinRankList.value[indexPath.item])
            } else {
                cell.configureNftCell(viewModel.outputNftRankList.value[indexPath.item], rank: indexPath.item)
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChartViewController()
        
        switch TrendingSection(rawValue: indexPath.section) {
        case .favorite:
            if indexPath.item < 3 {
                vc.viewModel.inputID.value = viewModel.outputFavoriteList.value[indexPath.item].id
            } else {
                tabBarController?.selectedIndex = 2
                return
            }
        case .top15Coin: vc.viewModel.inputID.value = viewModel.outputCoinRankList.value[indexPath.item].item.id
        default: break
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TrendingViewController {
    func bindData() {
        viewModel.outputFavoriteList.bind { _ in
            self.trendingView.collectionView.reloadSections(IndexSet(integer: 0))
        }
        
        viewModel.outputCoinRankList.bind { _ in
            self.trendingView.collectionView.reloadSections(IndexSet(integer: 1))
        }
        
        viewModel.outputNftRankList.bind { _ in
            self.trendingView.collectionView.reloadSections(IndexSet(integer: 2))
        }
    }
}
