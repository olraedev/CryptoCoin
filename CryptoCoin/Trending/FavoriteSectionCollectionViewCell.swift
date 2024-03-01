//
//  FavoriteCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/1/24.
//

import UIKit

class FavoriteSectionCollectionViewCell: UICollectionViewCell {
    
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
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteSectionCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(thumbImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentageLabel)
    }
    
    func configureView() {
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = Design.Color.customLightGray.fill
    }
    
    func configureCell(_ item: RmFavoriteCoinList) {
        guard let marketData = item.marketData else { return }
        let url = URL(string: marketData.image)
        
        thumbImageView.kf.setImage(with: url)
        nameLabel.text = marketData.name
        symbolLabel.text = marketData.symbol
        priceLabel.text = FormatManager.shared.decimal(marketData.currentPrice)
        percentageLabel.text = FormatManager.shared.percentage(marketData.priceChangePercentage24h)
        if marketData.priceChangePercentage24h > 0 {
            percentageLabel.textColor = Design.Color.customRed.fill
        } else {
            percentageLabel.textColor = Design.Color.customBlue.fill
        }
    }
    
    func configureConstraints() {
        thumbImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(16)
            make.leading.equalTo(contentView).offset(16)
            make.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.top)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).offset(-8)
            make.height.equalTo(22)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.bottom.equalTo(thumbImageView.snp.bottom)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).offset(-8)
            make.height.equalTo(22)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.bottom.equalTo(percentageLabel.snp.top).offset(-3)
            make.height.equalTo(22)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-16)
            make.height.equalTo(22)
        }
    }
}
