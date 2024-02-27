//
//  SearchViewController.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit

class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    let viewModel = SearchViewModel()
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    override func configureView(navigationTitle: String) {
        super.configureView(navigationTitle: "Search")
        
        searchView.searchController.searchBar.delegate = self
        navigationItem.searchController = searchView.searchController
        
        searchView.tableView.separatorStyle = .none
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchText.value = searchBar.text
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputCancelButtonTrigger.value = ()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputSearchList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let data = viewModel.outputSearchList.value[indexPath.row]
        let searchText = viewModel.inputSearchText.value
        
        cell.configureCell(data, searchText: searchText)
        
        return cell
    }
}

extension SearchViewController {
    func bindData() {
        viewModel.outputSearchList.bind { _ in
            self.searchView.tableView.reloadData()
        }
        
        viewModel.outputSearchState.bind { state in
            if state == false {
                self.showAlert(title: "검색 에러", message: "특수문자를 포함할 수 없습니다")
                self.searchView.searchController.searchBar.text = ""
            }
        }
    }
}
