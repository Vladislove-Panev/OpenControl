//  
//  MainViewController.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import UIKit

protocol MainViewInput: AnyObject {
    var presenter: MainPresenterInput? { get set }
    var output: MainViewOutput? { get set }
}

protocol MainViewOutput: AnyObject {
    
}

final class MainViewController: UIViewController {
    
    weak var output: MainViewOutput?
    var presenter: MainPresenterInput?
    
    private let navBarView = MainNavBarView()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.headerReferenceSize = .init(width: view.bounds.size.width - 32, height: 66)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(StockCVCell.self)
        collectionView.register(
            MainHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: MainHeaderView.self)
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = R.color.mainBackgroundColor()
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.mainBackgroundColor()
        navigationController?.isNavigationBarHidden = true
        setupLayout()
    }
    
    private func setupLayout() {
        
        view.addSubview(navBarView)
        view.addSubview(collectionView)
        
        navBarView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().inset(35)
        }
        
        collectionView.snp.makeConstraints { make in
            if Constants.isLargerThanIPhone6Plus {
                make.top.equalTo(navBarView.snp.bottom).offset(25)
            } else {
                make.top.equalTo(navBarView.snp.bottom)
            }
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: MainViewInput {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCVCell.reuseIdentifier, for: indexPath) as? StockCVCell,
            let presenter = presenter else { return UICollectionViewCell() }
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: MainHeaderView.self),
            for: indexPath
        )

        headerView.frame.size.height = 66

        return headerView
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.scaleAnimation(duration: 0.2)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        var height: CGFloat = 115
        
        if !Constants.isLargerThanIPhone6Plus {
            height = 100
        }
        
        return CGSize(width: width, height: height)
    }
}
