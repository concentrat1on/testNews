//
//  NewsModelRealmObject.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation
import RealmSwift

class ArticleRealmObject: Object {
    
    @Persisted var id: String
    @Persisted var source: String
    @Persisted var author: String?
    @Persisted var title: String
    @Persisted var articleDescription: String?
    @Persisted var url: String
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String
    
    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init(_ model: ArticleModel) {
        self.init()
        source = model.source.name
        author = model.author
        title = model.title
        articleDescription = model.description
        url = model.url
        urlToImage = model.urlToImage
        publishedAt = model.publishedAt
        id = model.source.name + model.publishedAt
    }
}
