//  
//  AuthRegViewController.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

protocol AuthRegViewInput: AnyObject {
    var presenter: AuthRegPresenterInput? { get set }
    var output: AuthRegViewOutput? { get set }
    var tableViewManager: AuthRegTableViewManager? { get set }
    
    func updateTableView(with viewModel: AuthRegViewModel)
}

protocol AuthRegViewOutput: AnyObject {
    func viewDidLoad()
}

final class AuthRegViewController: UIViewController {
    
    weak var output: AuthRegViewOutput?
    var presenter: AuthRegPresenterInput?
    var tableViewManager: AuthRegTableViewManager?
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.mainBackgroundColor()
        setupLayout()
        tableViewManager?.setup(tableView: tableView)
        output?.viewDidLoad()
    }
    
    private func setupLayout() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension AuthRegViewController: AuthRegViewInput {
    func updateTableView(with viewModel: AuthRegViewModel) {
        tableViewManager?.update(with: viewModel)
    }
}