//
//  SocialsTVCell.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

struct SocialMediaModel {
    
    enum Name {
        case vk, tg, ok, gosus, plus
    }
    
    let icon: UIImage?
    let name: Name
}

final class SocialsTVCell: UITableViewCell {
 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.setCharacterSpacing(-0.41)
        label.text = "Войти через"
        return label
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 40, height: 40)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .init(top: 5, left: 13, bottom: 5, right: 6)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(IconCVCell.self)
        collectionView.layer.cornerRadius = 8
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var model: [SocialMediaModel] = []
    
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
        contentView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.width.equalTo(260)
        }
    }
}

extension SocialsTVCell: Configurable {
    
    struct Model {
        let socialMediaModel: [SocialMediaModel]
    }
    
    func configure(with model: Model) {
        self.model = model.socialMediaModel
        collectionView.reloadData()
    }
}

extension SocialsTVCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCVCell.reuseIdentifier, for: indexPath) as? IconCVCell else { return UICollectionViewCell() }
        cell.configure(with: model[indexPath.item].icon)
        return cell
    }
}
