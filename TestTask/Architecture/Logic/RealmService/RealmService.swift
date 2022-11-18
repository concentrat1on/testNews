//
//  RealmService.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation
import RealmSwift

class RealmService: RealmServiceProtocol {
    
    let realm: Realm
    
    private func currentRealm() -> Realm? {
        return try? Realm(configuration: realm.configuration)
    }
    
    init() {
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.deleteRealmIfMigrationNeeded = true
        do {
            realm = try Realm(configuration: configuration)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        } catch let error as NSError {
            if error.code == 9 {
                do {
                    try FileManager.default.removeItem(at: configuration.fileURL!)
                    realm = try Realm(configuration: configuration)
                } catch let error as NSError {
                    let errorDescription = error.localizedDescription
                    let failuregDescription = error.localizedFailureReason
                    let errorString = "Error cleaning and opening Realm: \(errorDescription) : \(failuregDescription ?? "")"
                    
                    fatalError("\(errorString)")
                }
            } else {
                let errorDescription = error.localizedDescription
                let failuregDescription = error.localizedFailureReason
                let errorString = "Error opening Realm: \(errorDescription) : \(failuregDescription ?? "")"
                
                fatalError("\(errorString)")
            }
        }
    }
    
    func toggleArticleToFavorites(_ article: ArticleModel) {
        let key = article.source.name + article.publishedAt
        if isArticleContains(for: key) {
            deleteArticle(for: key)
        } else {
            saveArticle(article)
        }
    }
    
    private func saveArticle(_ article: ArticleModel) {
        let realm = currentRealm()
        try? realm?.write {
            realm?.add(ArticleRealmObject(article))
        }
    }
    
    private func deleteArticle(for key: String) {
        let realm = currentRealm()
        if let object = realm?.object(ofType: ArticleRealmObject.self, forPrimaryKey: key) {
            try? realm?.write {
                realm?.delete(object)
            }
        }
    }
    
    func isArticleContains(for key: String) -> Bool {
        let realm = currentRealm()
        return realm?.object(ofType: ArticleRealmObject.self, forPrimaryKey: key) != nil
    }
    
    func getArticles(completion: @escaping ([ArticleModel]?) -> ()) {
        let realm = currentRealm()
        if let objects = realm?.objects(ArticleRealmObject.self) {
            completion(objects.compactMap { ArticleModel($0) })
        }
    }
}
