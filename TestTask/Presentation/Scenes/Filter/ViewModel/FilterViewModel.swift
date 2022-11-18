//
//  FilterViewModel.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import Foundation

class FilterViewModel {
    
    var model: FilterModel?
    
    var headers: [Int : FilterTableViewHeader] = [:]
    var tableViewData: [[String]] = [Country.allCases.compactMap { $0.rawValue },
                                     Category.allCases.compactMap { $0.rawValue },
                                     Source.allCases.compactMap { $0.rawValue }]
    var activeSections: Set<Int> = []
    
    init(model: FilterModel? = FilterModel(country: nil, category: nil, source: nil)) {
        self.model = model
    }
}
