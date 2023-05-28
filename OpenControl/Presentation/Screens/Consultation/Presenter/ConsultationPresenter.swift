//  
//  ConsultationPresenter.swift
//  OpenControl
//
//  Created by Vladislav Panev on 26.05.2023.
//

import Foundation

protocol ConsultationPresenterInput {
    init(view: ConsultationViewInput, model: ConsultationModelInput)
}

final class ConsultationPresenter: ConsultationPresenterInput {
    
    private weak var view: ConsultationViewInput?
    private var model: ConsultationModelInput
    
    init(view: ConsultationViewInput, model: ConsultationModelInput) {
        self.view = view
        self.model = model
        setupOutputs()
    }
    
    private func setupOutputs() {
        view?.output = self
        model.output = self
    }
}

extension ConsultationPresenter: ConsultationViewOutput {
    func didTapEnrollBtn(with consultationId: String, topicId: String) {
        model.bookConsultation(with: consultationId, topicId: topicId)
    }
    
    
    func didSelectSubDepartment(with id: String) {
        model.getConsultationTopic(with: id)
    }
    
    func didSelectAppeal(with id: String) {
        model.getConsultationSlot(with: id)
    }
    
    func didSelectDate(with id: String) {
        
    }
    
    func didSelectDepartment(with id: String) {
        model.fetchSubDepartments(with: id)
    }
    
    func viewDidLoad() {
        model.fetchDepartments()
    }
}

extension ConsultationPresenter: ConsultationModelOutput {
    func didSuccessGetSubDepartments(data: [ConsultationModel.Department]) {
        view?.setSubDepartments(data)
    }
    
    func didFailureGetSubDepartments(error: Error) {
        view?.showError(error)
    }
    
    func didSuccessGetDepartments(data: [ConsultationModel.Department]) {
        view?.setDepartments(data)
    }
    
    func didFailureGetDepartments(error: Error) {
        view?.showError(error)
    }
    
    func didSuccessConsultationTopic(data: [ConsultationModel.Department]) {
        view?.setAppeal(data)
    }
    
    func didFailureConsultationTopic(error: Error) {
        view?.showError(error)
    }
    
    func didSuccessConsultationSlot(data: [ConsultationSlot]) {
        view?.setDate(data)
    }
    
    func didFailureConsultationSlot(error: Error) {
        print(error.localizedDescription)
        view?.showError(error)
    }
    
    func didSuccessBookConsultation(data: Consultation) {
        view?.showConfirm()
    }
    
    func didFailureBookConsultation(error: Error) {
        view?.showError(error)
    }
}
