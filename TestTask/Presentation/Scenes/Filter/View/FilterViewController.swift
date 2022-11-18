//
//  FilterViewController.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import UIKit
import SnapKit

protocol FilterViewControllerDelegate: AnyObject {
    func savedFilter(with model: FilterModel?)
}

class FilterViewController: BaseViewController {
    
    private weak var tableView: UITableView!
    
    let viewModel = FilterViewModel()
    weak var delegate: FilterViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayot()
    }
    
    @objc private func saveFilter() {
        delegate?.savedFilter(with: viewModel.model)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = FilterTableViewHeader()
        
        switch section {
        case 0:
            header.makeHeader(title: "Country", selection: viewModel.model?.country?.rawValue ?? Country.notSelected.rawValue)
        case 1:
            header.makeHeader(title: "Category", selection: viewModel.model?.category?.rawValue ?? Category.notSelected.rawValue)
        case 2:
            header.makeHeader(title: "Source", selection: viewModel.model?.source?.rawValue ?? Source.notSelected.rawValue)
        default:
            fatalError()
        }
        
        header.tag = section
        header.didTappedOnHeader = { index in
            
                var indexPaths = [IndexPath]()
                
            for row in 0..<self.viewModel.tableViewData[index].count {
                    indexPaths.append(IndexPath(row: row,
                                                section: index))
                }
            if !self.viewModel.activeSections.contains(index) {
                self.viewModel.activeSections.insert(index)
                self.tableView.insertRows(at: indexPaths,
                                          with: .fade)
            } else {
                self.viewModel.activeSections.remove(index)
                self.tableView.deleteRows(at: indexPaths,
                                          with: .fade)
            }
        }
        viewModel.headers[section] = header
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewModel.activeSections.contains(section) {
            return 0
        }
        
        return viewModel.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier) as? FilterTableViewCell else { fatalError() }
        cell.makeCell(viewModel.tableViewData[indexPath.section][indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.tableView(didSelectRowAt: indexPath)
    }
}

// MARK: - Layout
extension FilterViewController {
    
    private func setupLayot() {
        makeSaveButton()
        makeTableView()
    }
    
    private func makeSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveFilter))
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
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        self.tableView = tableView
    }
    
}
