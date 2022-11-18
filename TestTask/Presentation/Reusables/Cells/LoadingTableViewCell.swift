//
//  LoadingTableViewCell.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import UIKit
import SnapKit

class LoadingTableViewCell: UITableViewCell {
    
    private weak var activityIndicator: UIActivityIndicatorView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isActivityIndicator(active: Bool) {
        active ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
}

// MARK: - Layout
extension LoadingTableViewCell {
    
    private func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none
        makeActivityIndicator()
    }
    
    private func makeActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        contentView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(15)
        }
        
        activityIndicator.hidesWhenStopped = true
        self.activityIndicator = activityIndicator
    }
}
