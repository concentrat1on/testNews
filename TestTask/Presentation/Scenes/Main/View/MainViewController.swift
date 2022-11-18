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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as? NewsTableViewCell else { fatalError() }
        
        return cell
    }
    

}

//// MARK: - UITableViewDelegate
//extension MainViewController: UITableViewDelegate {
//
//}

// MARK: - Layout
extension MainViewController {
    
    private func setupLayout() {
        makeTableView()
    }
    
    private func makeTableView() {
        let tableView = UITableView()
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        self.tableView = tableView
    }
}
