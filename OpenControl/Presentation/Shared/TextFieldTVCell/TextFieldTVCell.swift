//
//  TextFieldTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit
import IQKeyboardManagerSwift

protocol TextFieldTVCellDelegate: AnyObject {
    func textFieldDidChange(
        _ text: String,
        errorPresentable: ErrorPresentable,
        type: AuthRegData.PlaceholderType
    )
}

final class TextFieldTVCell: UITableViewCell {
    
    private weak var delegate: TextFieldTVCellDelegate?
    
    private let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.setCharacterSpacing(-0.41)
        label.textColor = .black
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.backgroundColor = R.color.mainBackgroundColor()
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
    }
    
    private func setupTextField(
        with placeholder: String,
        isPassword: Bool,
        showPassIcon: Bool,
        type: AuthRegData.PlaceholderType
    ) -> UITextField {
        
        let textField = OCTextField(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 44))
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 17)
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: R.color.textFieldPlaceholderColor() ?? .black]
        )
        if isPassword {
            textField.isSecureTextEntry = true
        }
        if showPassIcon {
            textField.enablePasswordToggle()
        }
        textField.insetX = 16
        textField.insetY = 9
        textField.delegate = self
        textField.returnKeyType = .next
        textField.tag = type.rawValue
        
        if type == .mail {
            textField.keyboardType = .emailAddress
        } else if type == .phone {
            textField.keyboardType = .phonePad
        }
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }
    
    private func updateLyout(for title: String) {
        
        cellTitleLabel.text = "  \(title)"
        
        contentView.addSubview(cellTitleLabel)
        
        cellTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        contentStackView.snp.removeConstraints()
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func textFieldDidChange(_ textField: OCTextField) {
        
        guard let text = textField.text else { return }
        
        let trimmedString = text.trimmingCharacters(in: .whitespaces)
        textField.text = trimmedString
        
        let type = AuthRegData.PlaceholderType(rawValue: textField.tag) ?? .none
        
        delegate?.textFieldDidChange(trimmedString, errorPresentable: textField, type: type)
    }
}

extension TextFieldTVCell: Configurable {
    
    struct Model {
        let authRegData: AuthRegData
        weak var delegate: TextFieldTVCellDelegate?
    }
    
    func configure(with model: Model) {
        contentView.subviews.forEach({ $0.removeFromSuperview() })
        contentStackView.subviews.forEach({ $0.removeFromSuperview() })
        
        delegate = model.delegate
        
        contentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        for placeholder in model.authRegData.placeholders {
            let textField = setupTextField(
                with: placeholder.text,
                isPassword: placeholder.isPassword,
                showPassIcon: placeholder.showPassIcon,
                type: placeholder.type
            )
            contentStackView.addArrangedSubview(textField)
        }
        if let title = model.authRegData.title {
            updateLyout(for: title)
        }
    }
}

extension TextFieldTVCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        IQKeyboardManager.shared.goNext()
        return true
    }
}
