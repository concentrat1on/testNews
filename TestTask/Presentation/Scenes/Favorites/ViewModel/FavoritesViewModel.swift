//
//  FavoritesViewModel.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation

protocol FavoritesViewModelDelegate: AnyObject {
    func reloadTableView()
}

class FavoritesViewModel {
    
    weak var delegate: FavoritesViewModelDelegate?
    var models = [ArticleModel]()
    
    func loadData() {
        ApplicationDataProvider.shared.realm.getArticles { models in
            if let models = models {
                self.models = models
                self.delegate?.reloadTableView()
            }
        }
    }
    
    func toggleArticleToFavorites(for index: Int) {
        if models.count - 1 >= index {
            ApplicationDataProvider.shared.realm.toggleArticleToFavorites(models[index])
            models.remove(at: index)
            delegate?.reloadTableView()
        }
    }
}
