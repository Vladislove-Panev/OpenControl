//
//  StockCVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

final class StockCVCell: UICollectionViewCell {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.setCharacterSpacing(-0.41)
        label.isHidden = true
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.setCharacterSpacing(-0.08)
        label.isHidden = true
        return label
    }()
    
    private let subSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = R.color.subSubTitleColor()
        label.isHidden = true
        return label
    }()
    
    private lazy var iconStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView])
        return stackView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel, subSubTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconStackView, titleStackView])
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
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
    
    func configure(with model: StockModelProtocol) {
        
        if let iconImage = model.image {
            iconImageView.image = iconImage
            iconImageView.isHidden = false
        }
        
        if let title = model.title {
            titleLabel.text = title
            titleLabel.isHidden = false
        }
        
        if let subTitle = model.subTitle {
            subTitleLabel.text = subTitle
            subTitleLabel.isHidden = false
        }
        
        if let subSubTitle = model.subSubTitle {
            subSubTitleLabel.text = subSubTitle
            subSubTitleLabel.isHidden = false
        }
        
        contentView.backgroundColor = model.backgroundColor
        
        if let borderColor = model.borderColor {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = borderColor.cgColor
        }
        
        if model.isShadow {
            contentView.dropShadow()
        }
    }
    
    private func setupLayout() {
        
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
