//
//  UITableViewCell + Extension.swift
//  TestTask
//
//  Created by Илья on 16/11/2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
}
