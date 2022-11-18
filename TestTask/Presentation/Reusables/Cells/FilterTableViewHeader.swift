//
//  FilterTableViewHeader.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import Foundation
import UIKit
import SnapKit

class FilterTableViewHeader: UIView {
    
    private weak var titleLabel: UILabel!
    private weak var selectionLabel: UILabel!
    
    var didTappedOnHeader: ((Int) -> ())?
    
    var title = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeHeader(title: String? = nil, selection: String) {
        if let title = title {
            self.title = title
        }
        titleLabel.text = title ?? self.title
        selectionLabel.text = selection
    }
    
    @objc private func didTapped() {
        didTappedOnHeader?(tag)
    }
}

// MARK: - Layout
extension FilterTableViewHeader {
    
    private func setupLayout() {
        makeTitleLabel()
        makeSelectionLabel()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapped))
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
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
    
    private func makeSelectionLabel() {
        let selectionLabel = UILabel()
        addSubview(selectionLabel)
        
        selectionLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        selectionLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        selectionLabel.textColor = .systemBlue
        self.selectionLabel = selectionLabel
    }
}
