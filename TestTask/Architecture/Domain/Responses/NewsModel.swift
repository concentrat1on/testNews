//
//  NewsModel.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation

struct NewsModel: Codable {
    let articles: [ArticleModel]
}

// MARK: - Article
struct ArticleModel: Codable {
    let source: SourceModel
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    
    init(_ model: ArticleRealmObject) {
        source = SourceModel(model.source)
        author = model.author
        title = model.title
        description = model.articleDescription
        url = model.url
        urlToImage = model.urlToImage
        publishedAt = model.publishedAt
    }
}

// MARK: - Source
struct SourceModel: Codable {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
}
