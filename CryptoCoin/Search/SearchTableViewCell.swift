//
//  SearchTableViewCell.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {
    
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
    
    let favoriteButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchTableViewCell {
    func configureHierarchy() {
        contentView.addSubview(thumbImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(favoriteButton)
    }
    
    func configureCell(_ data: CoingeckoCoinsData, searchText: String?, favoriteList: [String]) {
        let url = URL(string: data.large)
        
        thumbImageView.kf.setImage(with: url)
        nameLabel.text = data.name
        symbolLabel.text = data.symbol
        // 즐겨찾기 리스트에 있는 경우
        if favoriteList.contains(data.id) {
            favoriteButton.setImage(.btnStarFill, for: .normal)
        } else {
            favoriteButton.setImage(.btnStar, for: .normal)
        }
        
        nameLabel.changeSearchText(searchText)
        symbolLabel.changeSearchText(searchText)
    }
    
    func configureConstraints() {
        thumbImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbImageView.snp.top)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(16)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-8)
            make.height.equalTo(22)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.bottom.equalTo(thumbImageView.snp.bottom)
            make.leading.equalTo(thumbImageView.snp.trailing).offset(16)
            make.trailing.equalTo(favoriteButton.snp.leading).offset(-8)
            make.height.equalTo(22)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(30)
        }
    }
}
