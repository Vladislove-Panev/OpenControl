//
//  ForgotPasswordTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

final class ForgotPasswordTVCell: UITableViewCell {
 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.text = "  Забыли пароль?"
        return label
    }()
    
    private lazy var recoverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Восстановить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, recoverButton])
        stackView.distribution = .fill
        stackView.spacing = 10
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
        contentView.addSubview(contentStackView)
        titleLabel.snp.contentHuggingHorizontalPriority = 253
        contentStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview()
        }
    }
}

extension ForgotPasswordTVCell: Configurable {
    
    struct Model {
        
    }
    
    func configure(with model: Model) {
        
    }
}
