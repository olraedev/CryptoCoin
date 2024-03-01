//
//  SearchViewController.swift
//  CryptoCoin
//
//  Created by SangRae Kim on 2/27/24.
//

import UIKit
import Toast

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
        
        cell.configureCell(data, searchText: searchText, favoriteList: viewModel.outputFavoriteListIDs.value)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChartViewController()
        vc.viewModel.inputID.value = viewModel.outputSearchList.value[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController {
    func bindData() {
        viewModel.outputSearchList.bind { _ in
            self.searchView.tableView.reloadData()
        }
        
        viewModel.outputSearchState.bind { state in
            switch state {
            case .includeSpecialCharacters, .length, .empty:
                self.showAlert(title: "검색 실패", message: state.rawValue)
            default: break
            }
        }
        
        viewModel.outputFavoriteListIDs.bind { _ in
            self.searchView.tableView.reloadData()
        }
        
        viewModel.outputFavoriteState.bind { state in
            switch state {
            case .append, .remove: self.view.makeToast(state.rawValue, duration: 0.5)
            case .full: self.showAlert(title: "즐겨찾기 실패", message: state.rawValue)
            }
        }
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        viewModel.inputFavoriteButtonTrigger.value = viewModel.outputSearchList.value[sender.tag].id
    }
}
