//
//  SegmentedControllTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

protocol SegmentedControllTVCellDelegate: AnyObject {
    func segmentedValueChanged(_ selectedValue: Int)
}

final class SegmentedControllTVCell: UITableViewCell {
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Регистрация", "Вход"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        segmentedControl.backgroundColor = R.color.segmentedControlBackgroundColor()
        segmentedControl.selectedSegmentTintColor = .white
        
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.interRegular400(with: 13) ?? .systemFont(ofSize: 13)
        ]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for:.selected)
        return segmentedControl
    }()
    
    private weak var delegate: SegmentedControllTVCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.backgroundColor = R.color.mainBackgroundColor()
        contentView.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            if Constants.isLargerThanIPhone6Plus {
                make.top.equalToSuperview().offset(121)
            } else {
                make.top.equalToSuperview().offset(57)
            }
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(32)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        delegate?.segmentedValueChanged(sender.selectedSegmentIndex)
    }
}

extension SegmentedControllTVCell: Configurable {
    
    struct Model {
        weak var delegate: SegmentedControllTVCellDelegate?
        let segmentedValue: Int
    }
    
    func configure(with model: Model) {
        delegate = model.delegate
        segmentedControl.selectedSegmentIndex = model.segmentedValue
    }
}
