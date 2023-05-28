//
//  OCTextField.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

class CalendarPickerFooterView: UIView {
    
    let didSelectTimeCompletionHandler: ((String) -> Void)
    
    var timeData: [TimeCell.Model] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15
        flowLayout.itemSize = .init(width: 65, height: 40)
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(TimeCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    init(didSelectTimeCompletionHandler: @escaping ((String) -> Void)) {
        self.didSelectTimeCompletionHandler = didSelectTimeCompletionHandler
        
        super.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white

        addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(95)
        }
    }
}

extension CalendarPickerFooterView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if timeData.isEmpty {
            collectionView.setEmptyMessage("На выбранную дату отсутствуют консультации")
        } else {
            collectionView.restore()
        }
        
        return timeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TimeCell.reuseIdentifier,
            for: indexPath
        ) as? TimeCell else { return UICollectionViewCell() }
        
        cell.configure(with: timeData[indexPath.item])
        return cell
    }
}

extension CalendarPickerFooterView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard timeData[indexPath.item].status == .available else { return }
        
        var newData: [TimeCell.Model] = []
        
        for (i, data) in timeData.enumerated() {
           if indexPath.row == i {
                newData.append(.init(id: data.id, name: data.name, isSelected: true, status: data.status))
            } else {
                newData.append(.init(id: data.id, name: data.name, isSelected: false, status: data.status))
            }
        }
        
        timeData = newData
        
        didSelectTimeCompletionHandler(timeData[indexPath.item].id)
    }
}
