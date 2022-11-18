//
//  Sources.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import Foundation

enum Source: String, CaseIterable {
    
    case notSelected = "Not Selected"
    case bbcNews = "BBC News"
    
    var shorten: String {
        switch self {
        case .notSelected:
            return ""
        case .bbcNews:
            return "bbc-news"
        }
    }
}
