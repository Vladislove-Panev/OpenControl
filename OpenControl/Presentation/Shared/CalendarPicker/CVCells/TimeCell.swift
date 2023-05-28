//
//  TimeCell.swift
//  Hoff
//
//  Created by Vladislav Panev on 28.05.2023.
//

import UIKit

final class TimeCell: UICollectionViewCell {
    
    struct Model: Comparable {
        let id: String
        let name: String
        let isSelected: Bool
        let status: ConsultationSlot.Status
        
        static func < (lhs: Self, rhs: Self) -> Bool {
            let firstDigit = Int(String(lhs.name.split(separator: ":").first ?? "0")) ?? 0
            let secondDigit = Int(String(rhs.name.split(separator: ":").first ?? "0")) ?? 0
            return firstDigit < secondDigit
        }
    }
    
    private let hintLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .interMedium500(with: 16)
        label.textColor = .black
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
    
    func configure(with model: Model) {
        hintLabel.text = model.name
        if model.isSelected && model.status == .available {
            makeSelected()
        } else if model.status == .busy || model.status == .notAvailable {
            makeUnavailable()
        } else {
            makeAvailable()
        }
    }
    
    func makeAvailable() {
        contentView.backgroundColor = R.color.timeCellAvailableColor()
        contentView.layer.borderWidth = 0
    }
    
    func makeUnavailable() {
        contentView.backgroundColor = R.color.startBackgroundColor()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = R.color.mainSecondaryColor()?.cgColor
    }
    
    func makeSelected() {
        contentView.backgroundColor = R.color.mainSecondaryColor()
        contentView.layer.borderWidth = 0
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
