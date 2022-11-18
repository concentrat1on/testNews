//
//  Sources.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import Foundation

enum Sources: String {
    
    case unknown = "Not Selected"
    case bbcNews = "bbcNews"
    
    var value: String {
        switch self {
        case .unknown:
            return ""
        case .bbcNews:
            return "BBC News"
        }
    }
}
