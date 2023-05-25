//
//  RightMessageCell.swift
//  ChatApp
//
//  Created by Vladislav Panev on 08.03.2022.
//

import UIKit

class RightMessageCell: MessageBubbleCell {
    
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
        
        NSLayoutConstraint.activate([
        
            contentView.topAnchor.constraint(equalTo: bubbleImage.topAnchor, constant: -5),
            contentView.trailingAnchor.constraint(equalTo: bubbleImage.trailingAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: bubbleImage.bottomAnchor, constant: 5),
            
            bubbleImage.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            bubbleImage.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleImage.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 20),
            bubbleImage.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            bubbleImage.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.75)
            
        ])
        
        let insets = UIEdgeInsets(
            top: 16,
            left: 10,
            bottom: 20,
            right: 10
        )
        
        let image = R.image.messageBubble()?.withTintColor(R.color.mainSecondaryColor() ?? .orange).withHorizontallyFlippedOrientation()
        messageLabel.textColor = .white
        bubbleImage.image = image?.resizableImage(withCapInsets: insets, resizingMode: .stretch)
    }
    
}
