//
//  ButtonTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

protocol ButtonTVCellDelegate: AnyObject {
    func buttonDidTap()
}

final class ButtonTVCell: UITableViewCell {
    
    private weak var delegate: ButtonTVCellDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 8
        
        button.backgroundColor = R.color.startBackgroundColor()
        button.layer.borderWidth = 1
        button.layer.borderColor = R.color.mainSecondaryColor()?.cgColor
        button.setTitleColor(R.color.buttonUnavailableTextColor(), for: .normal)
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
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
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(32)
            make.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setButtonAvailable() {
        button.backgroundColor = R.color.mainSecondaryColor()
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true
    }
    
    private func setButtonUnavailable() {
        button.backgroundColor = R.color.startBackgroundColor()
        button.layer.borderWidth = 1
        button.layer.borderColor = R.color.mainSecondaryColor()?.cgColor
        button.setTitleColor(R.color.buttonUnavailableTextColor(), for: .normal)
        button.isEnabled = false
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        sender.scaleAnimation(duration: 0.2) {
            self.delegate?.buttonDidTap()
        }
    }
}

extension ButtonTVCell: Configurable {
    
    struct Model {
        let title: String
        let isValid: Bool
        weak var delegate: ButtonTVCellDelegate?
    }
    
    func configure(with model: Model) {
        button.setTitle(model.title, for: .normal)
        delegate = model.delegate
        if model.isValid {
            setButtonAvailable()
        } else {
            setButtonUnavailable()
        }
    }
}
