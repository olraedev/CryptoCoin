//
//  RoundImageView.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit
import SnapKit

class RoundImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
        self.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
    }
}
