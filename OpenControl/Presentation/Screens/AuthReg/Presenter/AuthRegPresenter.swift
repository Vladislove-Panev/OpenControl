//  
//  AuthRegPresenter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import Foundation

protocol AuthRegPresenterInput {
    init(view: AuthRegViewInput, model: AuthRegModelInput, dataConverter: AuthRegDataConverter)
}

final class AuthRegPresenter: AuthRegPresenterInput {
    
    private weak var view: AuthRegViewInput?
    private var model: AuthRegModelInput
    private let dataConverter: AuthRegDataConverter
    private var currentSegmentedValue = 1
    
    init(view: AuthRegViewInput, model: AuthRegModelInput, dataConverter: AuthRegDataConverter) {
        self.view = view
        self.model = model
        self.dataConverter = dataConverter
        setupOutputs()
    }
    
    private func assemblyViewModel(with model: [AuthRegData]) -> AuthRegViewModel {
        dataConverter.convert(with: model, segmentedValue: currentSegmentedValue, delegate: self)
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension AuthRegPresenter: AuthRegViewOutput {
    func viewDidLoad() {
        let data = model.fetchAuthData()
        view?.updateTableView(with: assemblyViewModel(with: data))
    }
}

extension AuthRegPresenter: AuthRegModelOutput {
    
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
        view?.updateTableView(with: assemblyViewModel(with: data))
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
        view?.showTabBar()
    }
}
