//
//  PassRulesTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

final class PassRulesTVCell: UITableViewCell {
 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.text = "  Пароль должен содержать:"
        return label
    }()
    
    private let ruleOneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.text = "    • Не менее 8 символов"
        return label
    }()
    
    private let ruleTwoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.text = "    • Прописные буквы"
        return label
    }()
    
    private let ruleThreeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.text = "    • Цифры"
        return label
    }()
    
    private let ruleFourLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.text = "    • Строчные буквы"
        return label
    }()
    
    private lazy var rulesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ruleOneLabel, ruleTwoLabel, ruleThreeLabel, ruleFourLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        return stackView
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(rulesStackView)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(21)
        }
        
        rulesStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

extension PassRulesTVCell: Configurable {
    
    struct Model {
        
    }
    
    func configure(with model: Model) {
        
    }
}

