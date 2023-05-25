//
//  LogoView.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit
import SnapKit

final class LogoView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        label.text = "Цифровая платформа"
        label.setCharacterSpacing(-0.41)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Открытый Контроль"
        label.setCharacterSpacing(-0.41)
        return label
    }()
    
    private let dotView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.mainSecondaryColor()
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dotView.layer.cornerRadius = dotView.bounds.height / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(dotView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        dotView.snp.makeConstraints { make in
            make.size.equalTo(8)
            make.leading.equalTo(subtitleLabel.snp.trailing).offset(2)
            make.bottom.equalTo(subtitleLabel.snp.lastBaseline)
        }
    }
}
