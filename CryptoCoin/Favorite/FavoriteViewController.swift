//
//  FavoriteViewController.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit

class FavoriteViewController: BaseViewController {
    
    let favoriteView = FavoriteView()
    let viewModel = FavoriteViewModel()
    
    override func loadView() {
        view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 다른 화면으로 이동시, 타이머 종료..
        viewModel.timer.invalidate()
    }
    
    override func configureView(navigationTitle: String) {
        super.configureView(navigationTitle: "Favorite Coin")
        
        favoriteView.collectionView.delegate = self
        favoriteView.collectionView.dataSource = self
        favoriteView.collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)
        
        favoriteView.collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlled), for: .valueChanged)
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputFavoriteList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        
        cell.configureCell(viewModel.outputFavoriteList.value[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChartViewController()
        vc.viewModel.inputID.value = viewModel.outputFavoriteList.value[indexPath.item].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoriteViewController {
    func bindData() {
        viewModel.outputFavoriteList.bind { _ in
            self.favoriteView.collectionView.reloadData()
        }
        
        viewModel.outputRefreshState.bind { state in
            guard let state else { return }
            
            self.view.makeToast(state.rawValue, duration: 0.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.favoriteView.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc func refreshControlled() {
        viewModel.inputRefreshTrigger.value = ()
    }
}
