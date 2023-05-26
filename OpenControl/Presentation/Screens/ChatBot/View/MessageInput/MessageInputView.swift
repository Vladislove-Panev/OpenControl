//
//  MessageInputView.swift
//  OpenControl
//
//  Created by Vladislav Panev on 25.05.2023.
//

import UIKit

final class MessageInputView: UIView {
    
    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.backgroundColor = .white
        textView.font = .interRegular400(with: 17)
        textView.textColor = .black
        
        textView.returnKeyType = .default
        textView.textContainerInset = .init(top: 11, left: 14, bottom: 11, right: 30)
        textView.layer.borderColor = R.color.mainSecondaryColor()?.cgColor
        textView.layer.borderWidth = 1.5
        textView.layer.cornerRadius = 10
        textView.tintColor = R.color.mainSecondaryColor()
        textView.delegate = self
        return textView
    }()
    
    private lazy var micButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.micIcon(), for: .normal)
        return button
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.sendIcon(), for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.textFieldPlaceholderColor()
        label.text = "Текст"
        label.font = .interRegular400(with: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func openKeyboard() {
        messageTextView.becomeFirstResponder()
    }
    
    private func setupLayout() {
        
        addSubview(messageTextView)
        addSubview(micButton)
        addSubview(sendButton)
        addSubview(placeholderLabel)
        
        messageTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualTo(44)
        }
        
        micButton.snp.makeConstraints { make in
            make.height.equalTo(25)
            make.width.equalTo(17)
            make.trailing.equalTo(messageTextView).inset(8)
            make.centerY.equalTo(messageTextView)
        }
        
        sendButton.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.width.equalTo(26)
            make.trailing.equalTo(messageTextView).inset(8)
            make.centerY.equalTo(messageTextView)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.leading.equalTo(messageTextView).offset(19)
            make.centerY.equalTo(messageTextView)
        }
    }
}

extension MessageInputView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text,
              !text.isEmpty else {
            micButton.isHidden = false
            sendButton.isHidden = true
            placeholderLabel.isHidden = false
            return
        }
        
        micButton.isHidden = true
        sendButton.isHidden = false
        placeholderLabel.isHidden = true
    }
}
