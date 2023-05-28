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
        print(error.localizedDescription)
    }
    
    func didSuccessGetDepartments(data: [ConsultationModel.Department]) {
        view?.setDepartments(data)
    }
    
    func didFailureGetDepartments(error: Error) {
        print(error.localizedDescription)
    }
    
    func didSuccessConsultationTopic(data: [ConsultationModel.Department]) {
        view?.setAppeal(data)
    }
    
    func didFailureConsultationTopic(error: Error) {
        print(error.localizedDescription)
    }
    
    func didSuccessConsultationSlot(data: [ConsultationSlot]) {
        // view?.setDate(da)
    }
    
    func didFailureConsultationSlot(error: Error) {
        print(error.localizedDescription)
    }
    
    func didSuccessBookConsultation(data: Consultation) {
        
    }
    
    func didFailureBookConsultation(error: Error) {
        print(error.localizedDescription)
    }
}
