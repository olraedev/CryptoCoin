//
//  ChartViewController.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import UIKit
import DGCharts

class ChartViewController: UIViewController {
    
    let chartView = ChartView()
    let viewModel = ChartViewModel()
    
    override func loadView() {
        self.view = chartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.timer.invalidate()
    }
}

extension ChartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChartItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChartCollectionViewCell.identifier, for: indexPath) as! ChartCollectionViewCell
        
        cell.configureCell(viewModel.outputCoinMarketData.value, idx: indexPath.item)
        
        return cell
    }
}

extension ChartViewController {
    func configureView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(favoriteButtonClicked))
        
        chartView.collectionView.delegate = self
        chartView.collectionView.dataSource = self
        chartView.collectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.identifier)
    }
    
    func bindData() {
        viewModel.outputCoinMarketData.bind { marketData in
            self.chartView.designView(marketData)
            self.chartView.collectionView.reloadData()
        }
        
        viewModel.outputFavoriteState.bind { state in
            var image = UIImage.btnStar
            if state {
                image = UIImage.btnStarFill
            }
            guard let rightBarButton = self.navigationItem.rightBarButtonItem else { return }
            
            rightBarButton.image = image
        }
        
        viewModel.outputFavoriteButtonClickedState.bind { state in
            guard let state else { return }
            
            switch state {
            case .append, .remove: self.view.makeToast(state.rawValue, duration: 0.5)
            case .full: self.showAlert(title: "즐겨찾기 실패", message: state.rawValue)
            }
        }
        
        viewModel.outputRefreshState.bind { state in
            guard let state else { return }
            
            self.view.makeToast(state.rawValue, duration: 0.5)
        }
    }
    
    @objc func leftBarButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func favoriteButtonClicked() {
        viewModel.inputFavoriteButtonTrigger.value = ()
    }
}
