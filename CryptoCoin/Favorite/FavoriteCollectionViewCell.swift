//
//  FavoriteCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import UIKit
import SnapKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    let thumbImageView: RoundImageView = {
        let view = RoundImageView(frame: .zero)
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.mid.light
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
        view.font = Design.Font.biggest.light
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
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(thumbImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(percentageLabel)
    }
    
    func configureView() {
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.25
        layer.shadowColor = Design.Color.customBlack.fill.cgColor
        layer.cornerRadius = 5
        layer.masksToBounds = false
        
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .secondarySystemGroupedBackground
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
            percentageLabel.backgroundColor = Design.Color.customPink.fill
        } else {
            percentageLabel.textColor = Design.Color.customBlue.fill
            percentageLabel.backgroundColor = Design.Color.customSkyBlue.fill
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
            make.bottom.equalTo(percentageLabel.snp.top)
            make.trailing.equalTo(contentView).offset(-16)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(contentView).offset(-16)
            make.height.equalTo(22)
        }
    }
}
