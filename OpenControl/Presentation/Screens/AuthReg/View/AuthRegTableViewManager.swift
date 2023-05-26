//
//  AuthRegTableViewManager.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

protocol AuthRegTableViewManagerDelegate: AnyObject {
    
}

protocol AuthRegTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: AuthRegViewModel)
    func updateButtonCell(with viewModel: AuthRegViewModel)
}


final class AuthRegTableViewManager: NSObject {
    
    weak var delegate: AuthRegTableViewManagerDelegate?
    private weak var tableView: UITableView?
    private var viewModel: AuthRegViewModel?
    
    private func updateTableView(with viewModel: AuthRegViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
}


// MARK: - ProductDetailTableViewManagerInput
extension AuthRegTableViewManager: AuthRegTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(LogoTVCell.self)
        tableView.register(SegmentedControllTVCell.self)
        tableView.register(TextFieldTVCell.self)
        tableView.register(ButtonTVCell.self)
        tableView.register(ForgotPasswordTVCell.self)
        tableView.register(SocialsTVCell.self)
        tableView.register(PassRulesTVCell.self)
        tableView.register(CheckBoxTVCell.self)
        
        tableView.backgroundColor = R.color.mainBackgroundColor()
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 0, left: 0, bottom: 24, right: 0)
        
        self.tableView = tableView
    }
    
    func update(with viewModel: AuthRegViewModel) {
        updateTableView(with: viewModel)
    }
    
    func updateButtonCell(with viewModel: AuthRegViewModel) {
        var index: IndexPath = .init(row: 0, section: 0)
        for (i, section) in viewModel.sections.enumerated() {
            for (j, row) in section.rows.enumerated() {
                if row.reuseId == String(describing: ButtonTVCell.self) {
                    index = IndexPath(row: j, section: i)
                }
            }
        }
        self.viewModel = viewModel
        tableView?.reloadRows(at: [index], with: .fade)
    }
}


// MARK: - UITableViewDataSource
extension AuthRegTableViewManager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections.count ?? 0
    }
   
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel?.sections[safe: section]?.rows.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let row = viewModel?.sections[safe: indexPath.section]?.rows[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseId, for: indexPath)
        row.configurator.configure(cell: cell)
        return cell
    }
}


// MARK: - UITableViewDelegate
extension AuthRegTableViewManager: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        
    }
}
