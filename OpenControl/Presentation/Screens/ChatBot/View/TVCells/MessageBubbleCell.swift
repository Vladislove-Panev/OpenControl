//
//  MessageBubbleCell.swift
//  ChatApp
//
//  Created by Vladislav Panev on 08.03.2022.
//

import UIKit

enum MessageBubbleCellType: String {
  case rightText, leftText
}

class MessageBubbleCell: UITableViewCell {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .interRegular400(with: 16)
        return label
    }()
    
    let bubbleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.addSubview(bubbleImage)
        contentView.addSubview(messageLabel)
    }
}
