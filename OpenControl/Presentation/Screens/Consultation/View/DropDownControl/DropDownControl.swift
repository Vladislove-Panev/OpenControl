//
//  DropDownControl.swift
//  OpenControl
//
//  Created by Vladislav Panev on 26.05.2023.
//

import UIKit

final class DropDownControl: UIControl {
    
    var didSelectItemWithId: ((String) -> Void)?
    
    private(set) var isOpened = false
    private var title: String = ""
    private var data: [(id: String, name: String)] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = R.color.leftMessageBubbleColor()?.cgColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.dropUnavailableColor()
        label.font = .interRegular400(with: 17)
        label.text = "Test"
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.chevronDownIcon()?
            .withTintColor(R.color.dropUnavailableColor() ?? .gray)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let searchTextField: OCTextField = {
        let textField = OCTextField()
        textField.insetX = 18
        textField.font = .interRegular400(with: 17)
        textField.textColor = .black
        textField.tintColor = R.color.mainSecondaryColor()
        textField.addTopBorder(with: R.color.leftMessageBubbleColor(), andWidth: 1)
        textField.addBottomBorder(with: R.color.leftMessageBubbleColor(), andWidth: 1)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Найти",
            attributes: [NSAttributedString.Key.foregroundColor: R.color.textFieldPlaceholderColor() ?? .gray]
        )
        return textField
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.rowHeight = 44
        tableView.separatorStyle = .none
        tableView.register(DropDownTVCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var slideContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchTextField, tableView])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.layer.opacity = 0
        return stackView
    }()
    
    convenience init(title: String, data: [(id: String, name: String)] = []) {
        self.init(frame: .zero)
        self.title = title
        self.data = data
        titleLabel.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    override var isEnabled: Bool {
        willSet {
            if newValue {
                contentView.layer.borderWidth = 0
                titleLabel.textColor = R.color.buttonTitleColor()
                if isOpened {
                    chevronImageView.image = R.image.chevronUpIcon()
                } else {
                    chevronImageView.image = R.image.chevronDownIcon()
                }
                addShadow()
            } else {
                contentView.layer.borderWidth = 0
                titleLabel.textColor = R.color.dropUnavailableColor()
                if isOpened {
                    chevronImageView.image = R.image.chevronUpIcon()?
                        .withTintColor(R.color.dropUnavailableColor() ?? .gray)
                } else {
                    chevronImageView.image = R.image.chevronDownIcon()?
                        .withTintColor(R.color.dropUnavailableColor() ?? .gray)
                }
                popShadow()
            }
        }
    }
    
    func addData(_ data: [(id: String, name: String)]) {
        titleLabel.text = title
        self.data = data
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func openSlide() {
        
        guard isEnabled else { return }
        
        isOpened = true
        searchTextField.isHidden = false
        tableView.isHidden = false
        chevronImageView.image = R.image.chevronUpIcon()
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {

            self.slideContentStackView.snp.remakeConstraints { make in
                make.top.equalTo(self.titleLabel.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            self.slideContentStackView.layer.opacity = 1
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func closeSlide() {
        isOpened = false
        chevronImageView.image = R.image.chevronDownIcon()
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {

            self.slideContentStackView.snp.remakeConstraints { make in
                make.height.equalTo(0)
                make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
            self.slideContentStackView.layer.opacity = 0
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }, completion: ({ _ in
            self.searchTextField.isHidden = false
            self.tableView.isHidden = false
        }))
    }
    
    private func setupLayout() {
        
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(slideContentStackView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalToSuperview()
            make.height.equalTo(48)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(18)
            make.width.equalTo(12)
            make.height.equalTo(20)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(18)
        }
        
        slideContentStackView.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor(red: 0.554, green: 0.547, blue: 0.547, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 7)
        layer.shadowOpacity = 1
        layer.shadowRadius = 8.0
    }
    
    private func popShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
    }
}

extension DropDownControl: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTVCell.reuseIdentifier, for: indexPath) as? DropDownTVCell else { return UITableViewCell() }
        cell.configure(with: data[indexPath.item].name)
        return cell
    }
}

extension DropDownControl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        titleLabel.text = data[indexPath.item].name
        didSelectItemWithId?(data[indexPath.item].id)
    }
}
