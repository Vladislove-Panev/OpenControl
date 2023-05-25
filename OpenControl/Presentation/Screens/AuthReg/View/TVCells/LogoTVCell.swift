//
//  LogoTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

final class LogoTVCell: UITableViewCell {
 
    private let logoView = LogoView()
    
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
        contentView.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            if Constants.isLargerThanIPhone6Plus {
                make.top.equalToSuperview().offset(109)
            } else {
                make.top.equalToSuperview().offset(45)
            }
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension LogoTVCell: Configurable {
    
    struct Model {
        
    }
    
    func configure(with model: Model) {
        
    }
}
