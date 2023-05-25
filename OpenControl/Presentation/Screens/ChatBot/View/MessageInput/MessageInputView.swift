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
        
        textView.text = "Текст"
        textView.textColor = R.color.textFieldPlaceholderColor()
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        
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
    }
}

extension MessageInputView: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

        if updatedText.isEmpty {

            textView.text = "Текст"
            textView.textColor = R.color.textFieldPlaceholderColor()

            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            micButton.isHidden =  false
            sendButton.isHidden = true
        } else if textView.textColor == R.color.textFieldPlaceholderColor() && !text.isEmpty {
            
            textView.textColor = .black
            textView.text = text
            
            micButton.isHidden =  true
            sendButton.isHidden = false
            
        } else {
            return true
        }

        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if window != nil {
            if textView.textColor == R.color.textFieldPlaceholderColor() {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}
