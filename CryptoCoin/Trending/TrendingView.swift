//
//  TrendingView.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/29/24.
//

import UIKit

class TrendingView: BaseView {
    
    let tableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = Design.Color.customWhite.fill
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
