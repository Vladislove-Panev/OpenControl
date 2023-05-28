//
//  OCTextField.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

class CalendarPickerHeaderView: UIView {

    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .interRegular400(with: 14)
        label.text = "Month"
        label.textColor = .black
        label.textAlignment = .center
        label.accessibilityTraits = .header
        label.isAccessibilityElement = true
        return label
    }()
    
    lazy var dayOfWeekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var leftButton: OCButton = {
        let button = OCButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.chevronLeftIcon1(), for: .normal)
        button.addTarget(self, action: #selector(didLeftButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightButton: OCButton = {
        let button = OCButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.chevronRightIcon1(), for: .normal)
        button.addTarget(self, action: #selector(didRightButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return dateFormatter
    }()
    
    var baseDate = Date() {
        didSet {
            monthLabel.text = dateFormatter.string(from: baseDate)
        }
    }
    
    var leftButtonTappedCompletionHandler: (() -> Void)?
    var rightButtonTappedCompletionHandler: (() -> Void)?
    
    init(
        leftButtonTappedCompletionHandler: @escaping (() -> Void),
        rightButtonTappedCompletionHandler: @escaping (() -> Void)
    ) {
        self.leftButtonTappedCompletionHandler = leftButtonTappedCompletionHandler
        self.rightButtonTappedCompletionHandler = rightButtonTappedCompletionHandler
        
        super.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        layer.cornerCurve = .continuous
        layer.cornerRadius = 15
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(monthLabel)
        addSubview(dayOfWeekStackView)
        
        for dayNumber in 1...7 {
            let dayLabel = UILabel()
            dayLabel.font = .interMedium500(with: 16)
            dayLabel.textColor = R.color.dropUnavailableColor()
            dayLabel.textAlignment = .center
            dayLabel.text = dayOfWeekLetter(for: dayNumber)
            dayLabel.isAccessibilityElement = false
            dayOfWeekStackView.addArrangedSubview(dayLabel)
        }
    }
    
    @objc func didLeftButton() {
        leftButtonTappedCompletionHandler?()
    }
    
    @objc func didRightButton() {
        rightButtonTappedCompletionHandler?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func dayOfWeekLetter(for dayNumber: Int) -> String {
        switch dayNumber {
        case 1:
            return "Пн"
        case 2:
            return "Вт"
        case 3:
            return "Ср"
        case 4:
            return "Чт"
        case 5:
            return "Пт"
        case 6:
            return "Сб"
        case 7:
            return "Вс"
        default:
            return ""
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            leftButton.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 37),
            leftButton.widthAnchor.constraint(equalToConstant: 12),
            leftButton.heightAnchor.constraint(equalToConstant: 20),
            
            rightButton.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -37),
            rightButton.widthAnchor.constraint(equalToConstant: 12),
            rightButton.heightAnchor.constraint(equalToConstant: 20),
            
            monthLabel.topAnchor.constraint(equalTo: leftButton.topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 15),
            monthLabel.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -15),
            
            dayOfWeekStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            dayOfWeekStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            dayOfWeekStackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 22),
            dayOfWeekStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
