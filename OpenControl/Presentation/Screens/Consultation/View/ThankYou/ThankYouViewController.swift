//
//  ThankYouViewController.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import UIKit

final class ThankYouViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = R.image.confirmIcon()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .interMedium500(with: 17)
        label.text = "Ваша запись на консультацию получена и будет отправлена на подтверждение сотруднику КНО"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .interRegular400(with: 15)
        label.text = "После подтверждения вы получите уведомление на электронную почту."
        label.textColor = R.color.textFieldPlaceholderColor()
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(78)
            make.height.equalTo(106)
            make.width.equalTo(112)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(47)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(65)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(128)
        }
    }
}
