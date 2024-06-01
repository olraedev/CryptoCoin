//
//  RankCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/1/24.
//

import UIKit

class RankCollectionViewCell: UICollectionViewCell {
    
    let rankLabel = {
        let view = UILabel()
        view.font = Design.Font.biggest.bold
        return view
    }()
    
    let thumbImageView: RoundImageView = {
        let view = RoundImageView(frame: .zero)
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.small.bold
        view.textColor = Design.Color.customBlack.fill
        return view
    }()
    
    let symbolLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.smallest.light
        view.textColor = Design.Color.customGray.fill
        return view
    }()
    
    let priceLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.biggest.bold
        view.textColor = Design.Color.customBlack.fill
        return view
    }()
    
    let percentageLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.smallest.light
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(thumbImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentageLabel)
    }
    
    func configureCoinCell(_ coin: CoinItem) {
        let url = URL(string: coin.item.large)
        
        rankLabel.text = "\(coin.item.score + 1)"
        thumbImageView.kf.setImage(with: url)
        nameLabel.text = coin.item.name
        symbolLabel.text = coin.item.symbol
        priceLabel.text = String(format: "%.2f", coin.item.data.price)
        percentageLabel.text = FormatManager.shared.percentage(coin.item.data.priceChangePercentage24h.krw)
        
        if coin.item.data.priceChangePercentage24h.krw > 0 {
            percentageLabel.textColor = Design.Color.customRed.fill
        } else {
            percentageLabel.textColor = Design.Color.customBlue.fill
        }
    }
    
    func configureNftCell(_ item: NftsItem, rank: Int) {
        let url = URL(string: item.thumb)
        guard let doublePercentage = Double(item.data.floorPricePercentage) else { return }
        
        rankLabel.text = "\(rank + 1)"
        thumbImageView.kf.setImage(with: url)
        nameLabel.text = item.name
        symbolLabel.text = item.symbol
        priceLabel.text = item.data.floorPrice.removeHTMLTag
        percentageLabel.text = FormatManager.shared.percentage(doublePercentage)
        
        if doublePercentage > 0 {
            percentageLabel.textColor = Design.Color.customRed.fill
        } else {
            percentageLabel.textColor = Design.Color.customBlue.fill
        }
    }
    
    func configureConstraints() {
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView).offset(16)
            make.size.equalTo(25)
        }
        
        thumbImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(rankLabel.snp.trailing).offset(8)
            make.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.top)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
            make.width.equalTo(100)
            make.height.equalTo(22)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.bottom.equalTo(thumbImageView.snp.bottom)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
            make.width.equalTo(100)
            make.height.equalTo(22)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.trailing.equalTo(contentView).offset(-8)
            make.height.equalTo(22)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(symbolLabel.snp.bottom)
            make.trailing.equalTo(contentView)
            make.height.equalTo(22)
        }
    }
}
