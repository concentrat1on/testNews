//
//  NetworkingProtocol.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation
import Alamofire

protocol NetworkingProtocol {
    func getNews(searchText: String?, filterModel: FilterModel?, completion: @escaping (Result<NewsModel, AFError>) -> ())
}
