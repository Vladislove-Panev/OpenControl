//
//  MainNavBarView.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import UIKit

final class MainNavBarView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .interRegular400(with: 16)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.text = "Алексей Алексеевич"
        return label
    }()
    
    private lazy var userButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.userButtonIcon(), for: .normal)
        return button
    }()
    
    private lazy var notificationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.notificationButtonIcon(), for: .normal)
        return button
    }()
    
    private lazy var contentStackView: UIStackView = {
        let spacingView = UIView()
        let stackView = UIStackView(arrangedSubviews: [userButton, titleLabel, spacingView, notificationButton])
        stackView.distribution = .fill
        stackView.spacing = 9
        spacingView.translatesAutoresizingMaskIntoConstraints = false
        spacingView.widthAnchor.constraint(lessThanOrEqualToConstant: 1000).isActive = true
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
