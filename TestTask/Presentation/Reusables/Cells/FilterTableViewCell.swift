//
//  FilterTableViewCell.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    private weak var titleLabel : UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCell(_ title: String) {
        titleLabel.text = title
    }
    
}

extension FilterTableViewCell {
    
    private func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none
        makeTitleLabel()
    }
    
    private func makeTitleLabel() {
        let titleLabel = UILabel()
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = .black
        self.titleLabel = titleLabel
    }
    
}
