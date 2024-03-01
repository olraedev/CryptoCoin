//
//  RankCollectionViewCell.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 3/1/24.
//

import UIKit

class RankCollectionViewCell: UICollectionViewCell {
    
    let imageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "xmark")
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
        contentView.addSubview(imageView)
    }
    
    func configureView() {
        
    }
    
    func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
}
