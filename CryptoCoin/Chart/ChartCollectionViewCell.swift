//
//  ChartCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/28/24.
//

import UIKit
import SnapKit

class ChartCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.smallest.bold
        return view
    }()
    
    let valueLabel: UILabel = {
        let view = UILabel()
        view.font = Design.Font.smallest.light
        view.textColor = Design.Color.customBlack.fill
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

extension ChartCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
    }
    
    func configureCell(_ item: RmCoinMarketData?, idx: Int) {
        guard let item else { return }
        
        titleLabel.text = ChartItem.allCases[idx].title
        valueLabel.text = ChartItem.allCases[idx].returnValue(item)
        
        titleLabel.textColor = ChartItem.allCases[idx].color
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.directionalHorizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(22)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.directionalHorizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(22)
        }
    }
}
