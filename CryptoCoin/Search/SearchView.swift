//
//  SearchView.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    
    let tableView = UITableView()
    let searchController = UISearchController(searchResultsController: nil)

    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureView() {
        searchController.searchBar.placeholder = "코인을 검색해주세요"
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
}
