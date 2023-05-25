//
//  ButtonTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

final class ButtonTVCell: UITableViewCell {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = R.color.mainSecondaryColor()
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
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
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        sender.scaleAnimation(duration: 0.2)
        // sender.flashBtn(duration: 0.2)
    }
}

extension ButtonTVCell: Configurable {
    
    struct Model {
        let title: String
    }
    
    func configure(with model: Model) {
        button.setTitle(model.title, for: .normal)
    }
}
