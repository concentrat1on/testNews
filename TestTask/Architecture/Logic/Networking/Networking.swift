//
//  Networking.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation
import Alamofire

class Networking: NetworkingProtocol {
    
    var headers: HTTPHeaders?
    
    func getNews(searchText: String?, filterModel: FilterModel?, completion: @escaping (Result<NewsModel, AFError>) -> ()) {
        
        headers = ["x-api-key" : ApplicationDataProvider.shared.apiKey]
        
        var urlString = NetworkingEndpoint.baseURL
        if let searchText = searchText,
           !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            urlString.append("q=\(searchText)")
        } else if let filterModel = filterModel {
            if let source = filterModel.source {
                urlString.append("sources=\(source.shorten)")
            } else {
                if let country = filterModel.country {
                    urlString.append("country=\(country.shorten)")
                }
                if let category = filterModel.category {
                    urlString.append("\(urlString.contains("country") ? "&" : "")category=\(category.shorten)")
                }
            }
        } else {
            urlString.append("q=ukraine")
        }
        print(urlString)
        
        AF.request(
            urlString,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers)
        .validate()
        .responseString(encoding: String.Encoding.utf8) { response in
            
//            print(String(data: response.data!, encoding: .utf8)!)
            guard response.response != nil,
                  let data = response.data else {
                if let error = response.error {
                    completion(.failure(error))
                }
                return
            }
            
            if let decodedModel: NewsModel = try? JSONDecoder().decode(NewsModel.self, from: data) {
                completion(.success(decodedModel))
            }
        }
    }
}
