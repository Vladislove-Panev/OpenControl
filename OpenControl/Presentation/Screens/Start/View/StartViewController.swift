//  
//  StartViewController.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

protocol StartViewInput: AnyObject {
    var presenter: StartPresenterInput? { get set }
    var output: StartViewOutput? { get set }
}

protocol StartViewOutput: AnyObject {
    
}

final class StartViewController: UIViewController {
    
    weak var output: StartViewOutput?
    var presenter: StartPresenterInput?
    
    private let logoView = LogoView()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 16
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(StockCVCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = R.color.startBackgroundColor()
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("    Войти под другим полномочием", for: .normal)
        button.setTitleColor(R.color.buttonTitleColor(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.startBackgroundColor()
        setupLayout()
    }
    
    private func setupLayout() {
        
        view.addSubview(logoView)
        view.addSubview(collectionView)
        view.addSubview(enterButton)
        
        logoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(114)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(92)
            make.leading.trailing.equalToSuperview()
            make.height.lessThanOrEqualTo(258)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
}

extension StartViewController: StartViewInput {
    
}

extension StartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCVCell.reuseIdentifier, for: indexPath) as? StockCVCell,
            let presenter = presenter else { return UICollectionViewCell() }
        cell.configure(with: presenter.model(for: indexPath).stockModel)
        return cell
    }
}

extension StartViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = presenter?.model(for: indexPath) else { return }
        collectionView.cellForItem(at: indexPath)?.scaleAnimation(duration: 0.2) {
            switch model.navigateTo {
            case .kno:
                break
            case .entity:
                let vc = AuthRegAssembly.assembly()
                self.view.window?.rootViewController = vc
            }
        }
    }
}

extension StartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        let height: CGFloat = 113
        return CGSize(width: width, height: height)
    }
}
