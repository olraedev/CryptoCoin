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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
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
        bindData()
        
        chartView.collectionView.delegate = self
        chartView.collectionView.dataSource = self
        chartView.collectionView.register(ChartCollectionViewCell.self, forCellWithReuseIdentifier: ChartCollectionViewCell.identifier)
    }
    
    func bindData() {
        viewModel.outputCoinMarketData.bind { marketData in
            self.chartView.designView(marketData)
            self.chartView.collectionView.reloadData()
        }
    }
}
