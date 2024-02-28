//
//  ChartView.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import UIKit
import DGCharts

class ChartView: BaseView {
    
    let coinImageView = RoundImageView(frame: .zero)
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.highlight.bold
        view.textColor = Design.Color.customBlack.fill
        return view
    }()
    
    let priceLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.highlight.bold
        view.textColor = Design.Color.customBlack.fill
        return view
    }()
    
    let percentageLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.smallest.bold
        return view
    }()
    
    let lastUpdateLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.smallest.light
        view.textColor = Design.Color.customGray.fill
        return view
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    let chartView = LineChartView()
    
    let fullUpdateLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.smallest.light
        view.textColor = Design.Color.customGray.fill
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(coinImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(percentageLabel)
        addSubview(lastUpdateLabel)
        addSubview(collectionView)
        addSubview(chartView)
        addSubview(fullUpdateLabel)
    }
    
    func designView(_ item: RmCoinMarketData?) {
        guard let item else { return }
        let url = URL(string: item.image)
        
        coinImageView.kf.setImage(with: url)
        nameLabel.text = item.name
        priceLabel.text = FormatManager.shared.decimal(item.currentPrice)
        percentageLabel.text = FormatManager.shared.percentage(item.priceChangePercentage24h)
        lastUpdateLabel.text = "\(item.lastUpdate)"
        fullUpdateLabel.text = "\(item.lastUpdate)"
        
        if item.priceChangePercentage24h > 0 {
            percentageLabel.textColor = Design.Color.customRed.fill
        } else {
            percentageLabel.textColor = Design.Color.customBlue.fill
        }
    }
    
    override func configureConstraints() {
        coinImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.size.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.top)
            make.leading.equalTo(coinImageView.snp.trailing).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(30)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(30)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.height.equalTo(22)
        }
        
        lastUpdateLabel.snp.makeConstraints { make in
            make.top.equalTo(percentageLabel.snp.top)
            make.leading.equalTo(percentageLabel.snp.trailing).offset(8)
            make.height.equalTo(22)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(percentageLabel.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(self.snp.centerY)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY)
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(fullUpdateLabel.snp.top)
        }
        
        fullUpdateLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(22)
        }
    }
}

extension ChartView {
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (space * 3)
        
        layout.itemSize = CGSize(width: cellWidth/2, height: cellWidth/2/3)
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = space
        
        return layout
    }
}
