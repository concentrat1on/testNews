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
    
    func tableView(didSelectRowAt indexPath: IndexPath) {
        let selectedString = tableViewData[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:
            let country = Country(rawValue: selectedString) ?? .notSelected
            if country == .notSelected {
                model?.country = nil
            } else {
                model?.country = country
                model?.source = nil
                headers[2]?.makeHeader(selection: Source.notSelected.rawValue)
            }
        case 1:
            let category = Category(rawValue: selectedString) ?? .notSelected
            if category == .notSelected {
                model?.category = nil
            } else {
                model?.category = category
                model?.source = nil
                headers[2]?.makeHeader(selection: Source.notSelected.rawValue)
            }
        case 2:
            let source = Source(rawValue: selectedString) ?? .notSelected
            if source == .notSelected {
                model?.source = nil
            } else {
                model?.source = source
                model?.country = nil
                model?.category = nil
                headers[0]?.makeHeader(selection: Country.notSelected.rawValue)
                headers[1]?.makeHeader(selection: Category.notSelected.rawValue)
            }
        default: fatalError()
        }
        headers[indexPath.section]?.makeHeader(selection: selectedString)
    }
}
