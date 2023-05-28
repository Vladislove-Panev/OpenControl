//
//  DropDownTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 26.05.2023.
//

import UIKit

final class DropDownTVCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interRegular400(with: 17)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(17)
            make.centerY.equalToSuperview()
        }
    }
}
