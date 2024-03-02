//
//  MoreCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/2/24.
//

import UIKit
import SnapKit

class MoreCollectionViewCell: UICollectionViewCell {
    
    let moreLabel = {
        let view = UILabel()
        view.text = "더보기"
        view.textAlignment = .center
        view.font = Design.Font.biggest.bold
        view .textColor = Design.Color.customBlack.fill
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

extension MoreCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(moreLabel)
    }
    
    func configureView() {
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = Design.Color.customLightGray.fill
    }
    
    func configureConstraints() {
        moreLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
