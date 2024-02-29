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
        
        trendingView.tableView.delegate = self
        trendingView.tableView.dataSource = self
        trendingView.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        
        viewModel.outputFavoriteList.bind { _ in
            self.trendingView.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    override func configureView(navigationTitle: String) {
        super.configureView(navigationTitle: "Crypto Coin")
    }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TrendingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TrendingSection.allCases[section].headerTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TrendingSection.allCases[indexPath.section].height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(TrendingFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: TrendingFavoriteCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        
        return cell
    }
}

extension TrendingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputFavoriteList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingFavoriteCollectionViewCell.identifier, for: indexPath) as! TrendingFavoriteCollectionViewCell
        
        cell.configureCell(viewModel.outputFavoriteList.value[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChartViewController()
        vc.viewModel.inputID.value = viewModel.outputFavoriteList.value[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
}
