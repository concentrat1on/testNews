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
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}

// MARK: - Source
struct SourceModel: Codable {
    let name: String
}
