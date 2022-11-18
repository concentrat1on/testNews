//
//  Category.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import Foundation

enum Category: String, CaseIterable {
    
    case notSelected = "Not Selected"
    case business = "Business"
    case entertainment = "Entertainment"
    case _general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    
    var shorten: String {
        switch self {
        case .notSelected:
            return ""
        default:
            return rawValue.lowercased()
        }
    }
}
