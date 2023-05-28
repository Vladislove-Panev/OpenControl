//
//  ConsultationHeaderView.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import UIKit

final class ConsultationHeaderView: UIView {
    
    private lazy var leftButton: OCButton = {
        let button = OCButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.chevronLeftIcon1(), for: .normal)
        button.addTarget(self, action: #selector(didLeftButton), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interMedium500(with: 17)
        label.text = "Запись на консультацию"
        label.textColor = .black
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .interRegular400(with: 12)
        label.text = "Записаться на консультацию с сотрудником Контрольно Надзорных Органов"
        label.numberOfLines = 2
        label.textColor = R.color.textFieldPlaceholderColor()
        return label
    }()
    
    var leftButtonTappedCompletionHandler: (() -> Void)?
    
    init(leftButtonTappedCompletionHandler: @escaping (() -> Void)) {
        self.leftButtonTappedCompletionHandler = leftButtonTappedCompletionHandler
        
        super.init(frame: CGRect.zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        addSubview(leftButton)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        leftButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(12)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(leftButton.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func didLeftButton() {
        leftButtonTappedCompletionHandler?()
    }
}
