//
//  RealmServiceProtocol.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation

protocol RealmServiceProtocol {
    func toggleArticleToFavorites(_ article: ArticleModel)
    func isArticleContains(for key: String) -> Bool
    func getArticles(completion: @escaping ([ArticleModel]?) -> ())
}
