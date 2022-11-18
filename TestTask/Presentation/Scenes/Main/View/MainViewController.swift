//
//  MainViewController.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {

    private weak var tableView: UITableView!
    private weak var refreshControl: UIRefreshControl!
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc private func pullToRefresh() {
        viewModel.loadData()
    }
    
    @objc private func openFilter() {
        let filterViewController = FilterViewController()
        filterViewController.delegate = self
        filterViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterViewController, animated: true)
    }
    

}

// MARK: - MainViewModelDelegate
extension MainViewController: MainViewModelDelegate {
    
    func reloadTableView() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - FilterViewControllerDelegate
extension MainViewController: FilterViewControllerDelegate {
    
    func savedFilter(with model: FilterModel?) {
        print(model)
        viewModel.filterModel = model
    }

}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.models.count
        case 1:
            return viewModel.isLoading ? 1 : 0
        default: fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else { fatalError() }
            cell.makeCellWith(viewModel.models[indexPath.row], index: indexPath.row)
            cell.didTappedOnFavorite = { [unowned self] index in
                viewModel.toggleArticleToFavorites(for: index)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.identifier) as? LoadingTableViewCell else { fatalError() }
            cell.isActivityIndicator(active: viewModel.isLoading)
            return cell
        default: fatalError()
        }

    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webViewController = WebViewController()
        webViewController.urlString = viewModel.models[indexPath.row].url

        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel.scrollViewDidScroll(scrollView)
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.isSearching = true
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.isSearching = false
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchText = searchBar.text
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchText = nil
    }
}

// MARK: - Layout
extension MainViewController {
    
    private func setupLayout() {
        makeFilterButton()
        makeTableView()
        makeRefreshControl()
        makeSearchController()
        viewModel.delegate = self
        viewModel.loadData()
    }
    
    private func makeFilterButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openFilter))
    }
    
    private func makeTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.identifier)
        self.tableView = tableView
    }
    
    private func makeRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl
    }
    
    private func makeSearchController() {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
}
