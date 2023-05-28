//  
//  AuthRegPresenter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

protocol AuthRegPresenterInput {
    init(view: AuthRegViewInput, model: AuthRegModelInput, userType: UserType, dataConverter: AuthRegDataConverter)
}

final class AuthRegPresenter: AuthRegPresenterInput {
    
    private weak var view: AuthRegViewInput?
    private var model: AuthRegModelInput
    private let dataConverter: AuthRegDataConverter
    private var currentSegmentedValue = 1
    private var isButtonValid = false
    private var isCheckBoxChecked = false
    private let userType: UserType
    
    init(view: AuthRegViewInput, model: AuthRegModelInput, userType: UserType, dataConverter: AuthRegDataConverter) {
        self.view = view
        self.model = model
        self.dataConverter = dataConverter
        self.userType = userType
        setupOutputs()
    }
    
    private func assemblyViewModel(with model: [AuthRegData], isButtonValid: Bool) -> AuthRegViewModel {
        self.isButtonValid = isButtonValid
        return dataConverter.convert(with: model, segmentedValue: currentSegmentedValue, isButtonValid: isButtonValid, delegate: self)
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension AuthRegPresenter: AuthRegViewOutput {
    func viewDidLoad() {
        let data = model.fetchAuthData()
        view?.updateTableView(with: assemblyViewModel(with: data, isButtonValid: false))
    }
}

extension AuthRegPresenter: AuthRegModelOutput {
    func didSuccessRegisterUser(with data: RegisterUserResponse) {
        view?.showTabBar()
    }
    
    func didFailedRegisterUser(with error: Error) {
        view?.showAlert(with: error)
    }
    
    func didSuccessAuthUser(with data: AuthenticationUserResponse) {
        view?.showTabBar()
    }
    
    func didFailedAuthUser(with error: Error) {
        view?.showAlert(with: error)
    }
    
    func authEnteredDataUpdated(_ data: AuthRegModel.AuthEnteredData?) {
        if data?.isValid ?? false {
            if !isButtonValid {
                view?.updateButtonCell(with: assemblyViewModel(with: model.fetchAuthData(), isButtonValid: true))
            }
        } else {
            if isButtonValid {
                view?.updateButtonCell(with: assemblyViewModel(with: model.fetchAuthData(), isButtonValid: false))
            }
        }
    }
    
    func regEnteredDataUpdated(_ data: AuthRegModel.RegEnteredData?) {
        if data?.isValid ?? false,
           isCheckBoxChecked {
            if !isButtonValid {
                view?.updateButtonCell(with: assemblyViewModel(with: model.fetchRegData(), isButtonValid: true))
            }
        } else {
            if isButtonValid {
                view?.updateButtonCell(with: assemblyViewModel(with: model.fetchRegData(), isButtonValid: false))
            }
        }
    }
}

extension AuthRegPresenter: SegmentedControllTVCellDelegate {
    func segmentedValueChanged(_ selectedValue: Int) {
        currentSegmentedValue = selectedValue
        var data: [AuthRegData] = []
        if selectedValue == 0 {
            data = model.fetchRegData()
        } else {
            data = model.fetchAuthData()
        }
        view?.updateTableView(with: assemblyViewModel(with: data, isButtonValid: false))
    }
}

extension AuthRegPresenter: TextFieldTVCellDelegate {
    func textFieldDidChange(
        _ text: String,
        errorPresentable: ErrorPresentable,
        type: AuthRegData.PlaceholderType
    ) {
        if model.isValid(text, type: type) {
            errorPresentable.hideError()
        } else {
            errorPresentable.showError()
        }
    }
}

extension AuthRegPresenter: ButtonTVCellDelegate {
    func buttonDidTap() {
        if currentSegmentedValue == 0 {
            model.registerUser()
        } else {
            model.authUser(with: userType)
        }
    }
}

extension AuthRegPresenter: CheckBoxTVCellDelegate {
    func checkBoxDidChange(_ value: Bool) {
        isCheckBoxChecked = value
        if model.regUserEnteredData?.isValid ?? false,
           value {
            if !isButtonValid {
                view?.updateButtonCell(with: assemblyViewModel(with: model.fetchRegData(), isButtonValid: true))
            }
        } else {
            if isButtonValid {
                view?.updateButtonCell(with: assemblyViewModel(with: model.fetchRegData(), isButtonValid: false))
            }
        }
    }
}
