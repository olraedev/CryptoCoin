//
//  HeaderView.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/1/24.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    let titleLabel = {
        let view = UILabel()
        view.text = "dsfasdfa"
        view.textColor = Design.Color.customBlack.fill
        view.font = Design.Font.biggest.bold
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.directionalVerticalEdges.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
