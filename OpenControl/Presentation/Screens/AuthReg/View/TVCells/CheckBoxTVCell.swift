//
//  CheckBoxTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

protocol CheckBoxTVCellDelegate: AnyObject {
    func checkBoxDidChange(_ value: Bool)
}

final class CheckBoxTVCell: UITableViewCell {
 
    private weak var delegate: CheckBoxTVCellDelegate?
    
    private var isChecked: Bool = false
    
    private lazy var checkBoxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.setImage(R.image.checkBoxEmptyIcon(), for: .normal)
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 3
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
        
        let str = "Я принимаю условия соглашения о пользовании информационными системами и ресурсами города Москвы"
        let attributes = [NSAttributedString.Key.foregroundColor: R.color.mainSecondaryColor() ?? .red]
        let attrString = NSMutableAttributedString(string: str)
        attrString.addAttributes(attributes, range: NSRange(location: 19, length: str.count - 19))
        
        label.attributedText = attrString
        
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkBoxButton, titleLabel])
        stackView.distribution = .fillProportionally
        stackView.spacing = 12
        stackView.alignment = .top
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
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        checkBoxButton.snp.makeConstraints { make in
            make.size.equalTo(26)
        }
    }
    
    @objc private func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
        
        guard let text = titleLabel.attributedText?.string else {
            return
        }

        if let range = text.range(of: NSLocalizedString("соглашения о пользовании информационными системами и ресурсами города Москвы", comment: "соглашения")),
            recognizer.didTapAttributedTextInLabel(label: titleLabel, inRange: NSRange(range, in: text)) {
            print("TERMS!")
        }
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        isChecked.toggle()
        sender.setImage(isChecked ? R.image.checkBoxCheckMarkIcon() : R.image.checkBoxEmptyIcon(), for: .normal)
        sender.backgroundColor = isChecked ? R.color.mainSecondaryColor() : .clear
        delegate?.checkBoxDidChange(isChecked)
    }
}

extension CheckBoxTVCell: Configurable {
    
    struct Model {
        weak var delegate: CheckBoxTVCellDelegate?
    }
    
    func configure(with model: Model) {
        delegate = model.delegate
    }
}
