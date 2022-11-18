//
//  MainViewModel.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation
import UIKit

protocol MainViewModelDelegate: AnyObject {
    func showError(_ error: String)
    func reloadTableView()
}

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    var models = [ArticleModel]()
    var isLoading = Bool()
    var isSearching = Bool()
    
    var searchText: String? {
        didSet {
            if searchText != nil {
                filterModel = nil
                loadData()
            }
        }
    }
    
    var filterModel: FilterModel? {
        didSet {
            if filterModel != nil {
                searchText = nil
                loadData()
            }
        }
    }
    
    func loadData(append: Bool = false) {
        ApplicationDataProvider.shared.networking.getNews(searchText: searchText, filterModel: filterModel) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                print(append)
                if append {
                    self.models.append(contentsOf: news.articles)
                    self.isLoading = false
                } else {
                    self.models = news.articles
                }
                self.delegate?.reloadTableView()
            case .failure(let error):
                self.delegate?.showError(error.localizedDescription)
            }
        }
    }
    
    func toggleArticleToFavorites(for index: Int) {
        if models.count - 1 >= index {
            ApplicationDataProvider.shared.realm.toggleArticleToFavorites(models[index])
            delegate?.reloadTableView()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height * 2) && !isLoading && !isSearching && models.count > 0 {
            isLoading = true
            loadData(append: true)
        }
    }
}
