//  
//  ConsultationViewController.swift
//  OpenControl
//
//  Created by Vladislav Panev on 26.05.2023.
//

import UIKit
import FittedSheets

protocol ConsultationViewInput: AnyObject {
    var presenter: ConsultationPresenterInput? { get set }
    var output: ConsultationViewOutput? { get set }
    func setDepartments(_ departments: [ConsultationModel.Department])
    func setSubDepartments(_ departments: [ConsultationModel.Department])
    func setAppeal(_ departments: [ConsultationModel.Department])
    func setDate(_ departments: [ConsultationSlot])
    func showConfirm()
    func showError(_ error: Error)
}

protocol ConsultationViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectDepartment(with id: String)
    func didSelectSubDepartment(with id: String)
    func didSelectAppeal(with id: String)
    func didSelectDate(with id: String)
    func didTapEnrollBtn(with consultationId: String, topicId: String)
}

final class ConsultationViewController: UIViewController {
    
    weak var output: ConsultationViewOutput?
    var presenter: ConsultationPresenterInput?
    
    private var consultationSlots: [ConsultationSlot]?
    private var selectedSlot: ConsultationSlot?
    private var selectedTopicId: String?
    
    private lazy var headerView: ConsultationHeaderView = {
        let headerView = ConsultationHeaderView { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return headerView
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = R.color.mainBackgroundColor()
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.mainBackgroundColor()
        return view
    }()
    private lazy var firstDropDown: DropDownControl = {
        let dropDown = DropDownControl(title: "Орган контроля")
        dropDown.isEnabled = false
        dropDown.didSelectItemWithId = didSelectDepartment(with:)
        return dropDown
    }()
    private lazy var secondDropDown: DropDownControl = {
        let dropDown = DropDownControl(title: "Вид контроля")
        dropDown.isEnabled = false
        dropDown.didSelectItemWithId = didSelectSubDepartment(with:)
        return dropDown
    }()
    private lazy var thirdDropDown: DropDownControl = {
        let dropDown = DropDownControl(title: "Тема обращения")
        dropDown.isEnabled = false
        dropDown.didSelectItemWithId = didSelectAppeal(with:)
        return dropDown
    }()
    private lazy var fourthDropDown: DropDownControl = {
        let dropDown = DropDownControl(title: "Дата и время")
        dropDown.isEnabled = false
        dropDown.didSelectItemWithId = didSelectDate(with:)
        return dropDown
    }()
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 8
        
        button.backgroundColor = R.color.startBackgroundColor()
        button.layer.borderWidth = 1
        button.layer.borderColor = R.color.mainSecondaryColor()?.cgColor
        button.setTitleColor(R.color.buttonUnavailableTextColor(), for: .normal)
        button.setTitle("Записаться", for: .normal)
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.mainBackgroundColor()
        setupTapGestures()
        setupLayout()
        output?.viewDidLoad()
    }
    
    private func didSelectDepartment(with id: String) {
        closeAll()
        output?.didSelectDepartment(with: id)
        setButtonUnavailable()
    }
    
    private func didSelectSubDepartment(with id: String) {
        closeAll()
        output?.didSelectSubDepartment(with: id)
        setButtonUnavailable()
    }
    
    private func didSelectAppeal(with id: String) {
        closeAll()
        selectedTopicId = id
        output?.didSelectAppeal(with: id)
        setButtonUnavailable()
    }
    
    private func didSelectDate(with id: String) {
        closeAll()
        output?.didSelectDate(with: id)
        setButtonAvailable()
    }
    
    private func setupTapGestures() {
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(tap1))
        tap1.numberOfTapsRequired = 1
        tap1.cancelsTouchesInView = false
        tap1.delegate = self
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tap2))
        tap2.numberOfTapsRequired = 1
        tap2.cancelsTouchesInView = false
        tap2.delegate = self
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(tap3))
        tap3.numberOfTapsRequired = 1
        tap3.cancelsTouchesInView = false
        tap3.delegate = self
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(tap4))
        tap4.numberOfTapsRequired = 1
        tap4.cancelsTouchesInView = false
        tap4.delegate = self
        
        firstDropDown.addGestureRecognizer(tap1)
        secondDropDown.addGestureRecognizer(tap2)
        thirdDropDown.addGestureRecognizer(tap3)
        fourthDropDown.addGestureRecognizer(tap4)
    }
    
    private func setupLayout() {
        view.addSubview(headerView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(firstDropDown)
        contentView.addSubview(secondDropDown)
        contentView.addSubview(thirdDropDown)
        contentView.addSubview(fourthDropDown)
        contentView.addSubview(button)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(36)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        let contentG = scrollView.contentLayoutGuide
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(contentG)
            make.height.equalTo(scrollView.frameLayoutGuide).priority(250)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        firstDropDown.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(view.bounds.width - 42)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        secondDropDown.snp.makeConstraints { make in
            make.top.equalTo(firstDropDown.snp.bottom).offset(28)
            make.height.equalTo(48)
            make.width.equalTo(view.bounds.width - 42)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        thirdDropDown.snp.makeConstraints { make in
            make.top.equalTo(secondDropDown.snp.bottom).offset(28)
            make.height.equalTo(48)
            make.width.equalTo(view.bounds.width - 42)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        fourthDropDown.snp.makeConstraints { make in
            make.top.equalTo(thirdDropDown.snp.bottom).offset(28)
            make.height.equalTo(48)
            make.width.equalTo(view.bounds.width - 42)
            make.leading.trailing.equalToSuperview().inset(21)
        }
        button.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(fourthDropDown.snp.bottom).offset(28)
            make.height.equalTo(44)
            make.width.equalTo(view.bounds.width - 42)
            make.leading.trailing.equalToSuperview().inset(21)
            make.bottom.equalToSuperview().inset(46)
        }
    }
    
    private func closeAll() {
        closeFirstDropDown()
        closeSecondDropDown()
        closeThirdDropDown()
        closeFourthDropDown()
    }
    
    private func closeFirstDropDown() {
        firstDropDown.closeSlide()
        animateSlide {
            self.firstDropDown.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(48)
                make.leading.trailing.equalToSuperview().inset(21)
                make.width.equalTo(self.view.bounds.width - 42)
            }
        }
    }
    
    private func closeSecondDropDown() {
        secondDropDown.closeSlide()
        animateSlide {
            self.secondDropDown.snp.remakeConstraints { make in
                make.top.equalTo(self.firstDropDown.snp.bottom).offset(28)
                make.height.equalTo(48)
                make.width.equalTo(self.view.bounds.width - 42)
                make.leading.trailing.equalToSuperview().inset(21)
            }
        }
    }
    
    private func closeThirdDropDown() {
        thirdDropDown.closeSlide()
        animateSlide {
            self.thirdDropDown.snp.remakeConstraints { make in
                make.top.equalTo(self.secondDropDown.snp.bottom).offset(28)
                make.height.equalTo(48)
                make.width.equalTo(self.view.bounds.width - 42)
                make.leading.trailing.equalToSuperview().inset(21)
            }
        }
    }
    
    private func closeFourthDropDown() {
        fourthDropDown.closeSlide()
        animateSlide {
            self.fourthDropDown.snp.remakeConstraints { make in
                make.top.equalTo(self.thirdDropDown.snp.bottom).offset(28)
                make.height.equalTo(48)
                make.width.equalTo(self.view.bounds.width - 42)
                make.leading.trailing.equalToSuperview().inset(21)
            }
        }
    }
    
    private func setButtonAvailable() {
        button.backgroundColor = R.color.mainSecondaryColor()
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = true
    }
    
    private func setButtonUnavailable() {
        button.backgroundColor = R.color.startBackgroundColor()
        button.layer.borderWidth = 1
        button.layer.borderColor = R.color.mainSecondaryColor()?.cgColor
        button.setTitleColor(R.color.buttonUnavailableTextColor(), for: .normal)
        button.isEnabled = false
    }
    
    @objc private func buttonDidTap(_ sender: UIButton) {
        guard let selectedSlot = selectedSlot,
        let selectedTopicId = selectedTopicId else { return }
        output?.didTapEnrollBtn(with: selectedSlot.id, topicId: selectedTopicId)
    }
    
    @objc private func tap1() {
        if firstDropDown.isOpened {
            closeFirstDropDown()
        } else {
            firstDropDown.openSlide()
            animateSlide {
                self.firstDropDown.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.height.equalTo(240)
                    make.width.equalTo(self.view.bounds.width - 42)
                    make.leading.trailing.equalToSuperview().inset(21)
                }
            }
        }
    }
    
    @objc private func tap2() {
        if secondDropDown.isOpened {
            closeSecondDropDown()
        } else {
            secondDropDown.openSlide()
            animateSlide {
                self.secondDropDown.snp.remakeConstraints { make in
                    make.top.equalTo(self.firstDropDown.snp.bottom).offset(28)
                    make.height.equalTo(240)
                    make.width.equalTo(self.view.bounds.width - 42)
                    make.leading.trailing.equalToSuperview().inset(21)
                }
            }
        }
    }
    
    @objc private func tap3() {
        if thirdDropDown.isOpened {
            closeThirdDropDown()
        } else {
            thirdDropDown.openSlide()
            animateSlide {
                self.thirdDropDown.snp.remakeConstraints { make in
                    make.top.equalTo(self.secondDropDown.snp.bottom).offset(28)
                    make.height.equalTo(240)
                    make.width.equalTo(self.view.bounds.width - 42)
                    make.leading.trailing.equalToSuperview().inset(21)
                }
            }
        }
    }
    
    @objc private func tap4() {
        
        guard let consultationSlots = consultationSlots else { return }
        
        let calendarVC = CalendarPickerViewController(
            baseDate: Date.init(),
            consultationSlots: consultationSlots
        ) { [weak self] selectedSlot in
            self?.selectedSlot = selectedSlot
            self?.fourthDropDown.setTitle(selectedSlot.slotTime)
            self?.setButtonAvailable()
        }
        
        let options = SheetOptions(
            shrinkPresentingViewController: false
        )
        
        let sheetController = SheetViewController(controller: calendarVC, sizes: [.intrinsic], options: options)
        
        self.present(sheetController, animated: true, completion: nil)
    }
    
    private func animateSlide(_ animation: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
            animation()
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension ConsultationViewController: ConsultationViewInput {
    func showConfirm() {
        let thankYouVC = ThankYouViewController()
        
        let options = SheetOptions(
            shrinkPresentingViewController: false
        )
        
        let sheetController = SheetViewController(controller: thankYouVC, sizes: [.intrinsic], options: options)
        
        self.present(sheetController, animated: true, completion: nil)
    }
    
    func showError(_ error: Error) {
        showErrorAlert(error: error)
    }
    
    func setAppeal(_ departments: [ConsultationModel.Department]) {
        thirdDropDown.addData(departments.map({ ($0.id, $0.name) }))
        thirdDropDown.isEnabled = true
        fourthDropDown.isEnabled = false
    }
    
    func setDate(_ departments: [ConsultationSlot]) {
        consultationSlots = departments
        fourthDropDown.isEnabled = true
    }
    
    func setSubDepartments(_ departments: [ConsultationModel.Department]) {
        secondDropDown.addData(departments.map({ ($0.id, $0.name) }))
        secondDropDown.isEnabled = true
        thirdDropDown.isEnabled = false
        fourthDropDown.isEnabled = false
    }
    
    func setDepartments(_ departments: [ConsultationModel.Department]) {
        firstDropDown.addData(departments.map({ ($0.id, $0.name) }))
        firstDropDown.isEnabled = true
        secondDropDown.isEnabled = false
        thirdDropDown.isEnabled = false
        fourthDropDown.isEnabled = false
    }
}

extension ConsultationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: firstDropDown.tableView) ?? false ||
            touch.view?.isDescendant(of: secondDropDown.tableView) ?? false ||
            touch.view?.isDescendant(of: thirdDropDown.tableView) ?? false ||
            touch.view?.isDescendant(of: fourthDropDown.tableView) ?? false {
            return false
        }
        return true
    }
}
