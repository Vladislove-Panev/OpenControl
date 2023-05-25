//  
//  ChatBotViewController.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import UIKit
import IQKeyboardManagerSwift

protocol ChatBotViewInput: AnyObject {
    var presenter: ChatBotPresenterInput? { get set }
    var output: ChatBotViewOutput? { get set }
}

protocol ChatBotViewOutput: AnyObject {
    
}

final class ChatBotViewController: UIViewController {
    
    weak var output: ChatBotViewOutput?
    var presenter: ChatBotPresenterInput?
    
    private var needScrollToBottom = true
    private var isFirstLaunch = true
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(LeftMessageCell.self)
        tableView.register(RightMessageCell.self)
        tableView.backgroundColor = R.color.mainBackgroundColor()
        
        tableView.dataSource = self
        return tableView
    }()
    private let messageInputView = MessageInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.mainBackgroundColor()
        setupLayout()
        addLogoToNavigationBarItem(R.image.chatBotLogo(), height: 40)
        navigationController?.isNavigationBarHidden = false
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 10
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstLaunch {
            updateContentInsetForTableView(tableView: tableView, animated: false)
            scrollToBottom(animated: false)
            isFirstLaunch = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputView.openKeyboard()
    }
    
    private func setupLayout() {
        
        view.addSubview(tableView)
        view.addSubview(messageInputView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        messageInputView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().inset(23)
            make.bottom.equalToSuperview().inset(11)
        }
    }
    
    private func scrollToBottom(animated: Bool) {
        guard needScrollToBottom,
              let row = presenter?.numberOfRowsInSection(in: 0) else { return }
        
        tableView.scrollToRow(
            at: IndexPath(row: row - 1, section: 0),
            at: .bottom,
            animated: animated
        )
        needScrollToBottom = false
    }
    
    func updateContentInsetForTableView(tableView: UITableView, animated: Bool) {
               
        let lastRow = tableView.numberOfRows(inSection: 0)
        let lastIndex = lastRow > 0 ? lastRow - 1 : 0
        
        let lastIndexPath = IndexPath(row: lastIndex, section: 9)
        
        
        let lastCellFrame = tableView.rectForRow(at: lastIndexPath)
        let topInset = max(tableView.frame.height - lastCellFrame.origin.y - lastCellFrame.height, 0)
        
        var contentInset = tableView.contentInset
        contentInset.top = topInset
        
        _ = UIView.AnimationOptions.beginFromCurrentState
        
        if animated {
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                tableView.contentInset = contentInset
            })
        } else {
            tableView.contentInset = contentInset
        }
    }
}

extension ChatBotViewController: ChatBotViewInput {
    
}

extension ChatBotViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = presenter?.model(for: indexPath) else { return UITableViewCell() }
        
        var cell: MessageBubbleCell?
        
        switch model.sender {
        case .bot:
            let leftMessageCell = tableView.dequeueReusableCell(withIdentifier: LeftMessageCell.reuseIdentifier, for: indexPath) as? LeftMessageCell
            leftMessageCell?.messageLabel.text = model.message
            cell = leftMessageCell
        case .user:
            let rightMessageCell = tableView.dequeueReusableCell(withIdentifier: RightMessageCell.reuseIdentifier, for: indexPath) as? RightMessageCell
            rightMessageCell?.messageLabel.text = model.message
            cell = rightMessageCell
        }
        
        return cell ?? UITableViewCell()
    }
}
