//
//  FavoritesViewController.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import UIKit
import SnapKit

class FavoritesViewController: BaseViewController {
    
    private weak var tableView: UITableView!
    
    let viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }

}

// MARK: - MainViewModelDelegate
extension FavoritesViewController: FavoritesViewModelDelegate {
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else { fatalError() }
        cell.makeCellWith(viewModel.models[indexPath.row], index: indexPath.row)
        cell.didTappedOnFavorite = { [unowned self] index in
            viewModel.toggleArticleToFavorites(for: index)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {

}

// MARK: - Layout
extension FavoritesViewController {
    
    private func setupLayout() {
        makeTableView()
        viewModel.delegate = self
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
        
        self.tableView = tableView
    }
}
