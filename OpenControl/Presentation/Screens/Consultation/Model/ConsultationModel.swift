//  
//  ConsultationModel.swift
//  OpenControl
//
//  Created by Vladislav Panev on 26.05.2023.
//

import Foundation

protocol ConsultationModelOutput: AnyObject {
    func didSuccessGetSubDepartments(data: [ConsultationModel.Department])
    func didFailureGetSubDepartments(error: Error)
    func didSuccessGetDepartments(data: [ConsultationModel.Department])
    func didFailureGetDepartments(error: Error)
    func didSuccessConsultationTopic(data: [ConsultationModel.Department])
    func didFailureConsultationTopic(error: Error)
    func didSuccessConsultationSlot(data: [ConsultationSlot])
    func didFailureConsultationSlot(error: Error)
    func didSuccessBookConsultation(data: Consultation)
    func didFailureBookConsultation(error: Error)
}

protocol ConsultationModelInput {
    var output: ConsultationModelOutput? { get set }
    func fetchDepartments()
    func fetchSubDepartments(with id: String)
    func getConsultationTopic(with id: String)
    func getConsultationSlot(with id: String)
    func bookConsultation(with id: String, topicId: String)
}

final class ConsultationModel {
    
    struct Department {
        let id: String
        let name: String
    }
    
    weak var output: ConsultationModelOutput?
    
    private let service: ConsultationServiceProtocol
    private let userDefaults: UserDefaultsServiceProtocol
    
    private var departments: [Department] = []
    private var subDepartments: [Department] = []
    private var consultationTopic: [Department] = []
    private var consultationSlot: [ConsultationSlot] = []
    private var consultationData: Consultation?
    
    init(
        service: ConsultationServiceProtocol,
        userDefaults: UserDefaultsServiceProtocol
    ) {
        self.service = service
        self.userDefaults = userDefaults
    }
}

extension ConsultationModel: ConsultationModelInput {
    func fetchSubDepartments(with id: String) {
        service.getSubDepartment(with: id) { [weak self] result in
            switch result {
            case .success(let data):
                guard !data.isEmpty else {
                    self?.output?.didFailureConsultationTopic(error: NSError(domain: "0", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет видов контроля для выбранного органа контроля"]))
                    return
                }
                let departments = data.map({ Department(id: String($0.id), name: $0.name) })
                self?.output?.didSuccessGetSubDepartments(data: departments)
                self?.subDepartments = departments
            case .failure(let error):
                self?.output?.didFailureGetSubDepartments(error: error)
            }
        }
    }
    
    func fetchDepartments() {
        service.getDepartments { [weak self] result in
            switch result {
            case .success(let data):
                guard !data.isEmpty else {
                    self?.output?.didFailureConsultationTopic(error: NSError(domain: "0", code: 0, userInfo: [NSLocalizedDescriptionKey: "К сожалению, мы не смогли найти информацию по органам контроля, попробуйте, пожалуйста, зайти попозже"]))
                    return
                }
                let departments = data.map({ Department(id: String($0.id), name: $0.name) })
                self?.output?.didSuccessGetDepartments(data: departments)
                self?.departments = departments
            case .failure(let error):
                self?.output?.didFailureGetDepartments(error: error)
            }
        }
    }
    
    func getConsultationTopic(with id: String) {
        service.getConsultationTopic(with: id) { [weak self] result in
            switch result {
            case .success(let data):
                guard !data.isEmpty else {
                    self?.output?.didFailureConsultationTopic(error: NSError(domain: "0", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет слотов для выбранного вида контроля"]))
                    return
                }
                let consultationTopic = data.map({ Department(id: String($0.id), name: $0.topic) })
                self?.output?.didSuccessConsultationTopic(data: consultationTopic)
                self?.consultationTopic = consultationTopic
            case .failure(let error):
                self?.output?.didFailureConsultationTopic(error: error)
            }
        }
    }
    
    func getConsultationSlot(with id: String) {
        service.getConsultationSlot(with: id) { [weak self] result in
            switch result {
            case .success(let data):
                guard !data.isEmpty else {
                    self?.output?.didFailureConsultationSlot(error: NSError(domain: "0", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет слотов для выбранного обращения"]))
                    return
                }
                self?.output?.didSuccessConsultationSlot(data: data)
                self?.consultationSlot = data
            case .failure(let error):
                self?.output?.didFailureConsultationSlot(error: error)
            }
        }
    }
    
    func bookConsultation(with id: String, topicId: String) {
        guard let userId = try? userDefaults.get(
            objectType: RegisterUserResponse.self,
            forKey: .userRegData
        )?.id,
              let topicName = consultationTopic.first(where: { $0.id == topicId })?.name else {
            output?.didFailureBookConsultation(error: NSError(domain: "0", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет userId"]))
            return
        }
        
        let request = BookSlotRequest(
            topic: topicName,
            userId: userId,
            consultationSlotId: id
        )
        
        service.bookConsultation(with: request) { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.didSuccessBookConsultation(data: data)
                self?.consultationData = data
            case .failure(let error):
                self?.output?.didFailureConsultationSlot(error: error)
            }
        }
    }
}
