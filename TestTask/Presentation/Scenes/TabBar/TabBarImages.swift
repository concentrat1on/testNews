//
//  TabBarImages.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation
import UIKit

enum TabBarImages {
    case main
    case favorites
    
    var image: UIImage? {
        switch self {
        case .main:
            return UIImage(systemName: "house")
        case .favorites:
            return UIImage(systemName: "heart")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .main:
            return UIImage(systemName: "house.fill")
        case .favorites:
            return UIImage(systemName: "heart.fill")
        }
    }
}
