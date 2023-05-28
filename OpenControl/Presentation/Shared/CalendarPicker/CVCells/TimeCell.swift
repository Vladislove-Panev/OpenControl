//
//  TimeCell.swift
//  Hoff
//
//  Created by Vladislav Panev on 28.05.2023.
//

import UIKit

final class TimeCell: UICollectionViewCell {
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .interMedium500(with: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpLayout()
    }
    
    func configure(with hint: String) {
        hintLabel.text = hint
    }
    
    private func setUpLayout() {
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = R.color.timeCellAvailableColor()
        contentView.addSubview(hintLabel)
        
        hintLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(9)
            make.trailing.equalToSuperview().inset(9)
            make.bottom.equalToSuperview().inset(9)
        }
    }
}
