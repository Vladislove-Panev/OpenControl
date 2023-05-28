//
//  ConsultationService.swift
//  OpenControl
//
//  Created by Vladislav Panev on 28.05.2023.
//

import Foundation

protocol ConsultationServiceProtocol {
    func getDepartments(completion: @escaping (Result<[DepartmentDTO], Error>) -> Void)
    func getSubDepartment(
        with id: String,
        completion: @escaping (Result<[SubDepartmentDTO], Error>) -> Void
    )
    func getConsultationTopic(
        with id: String,
        completion: @escaping (Result<[ConsultationTopic], Error>) -> Void
    )
    func getConsultationSlot(
        with id: String,
        completion: @escaping (Result<[ConsultationSlot], Error>) -> Void
    )
    func bookConsultation(
        with data: BookSlotRequest,
        completion: @escaping (Result<Consultation, Error>) -> Void
    )
}

final class ConsultationService: ConsultationServiceProtocol {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getDepartments(completion: @escaping (Result<[DepartmentDTO], Error>) -> Void) {
        networkManager.request(endpoint: OpenControlEndpoint.department, completion: completion)
    }
    
    func getSubDepartment(
        with id: String,
        completion: @escaping (Result<[SubDepartmentDTO], Error>) -> Void
    ) {
        networkManager.request(endpoint: OpenControlEndpoint.subDepartment(id: id), completion: completion)
    }
    
    func getConsultationTopic(
        with id: String,
        completion: @escaping (Result<[ConsultationTopic], Error>) -> Void
    ) {
        networkManager.request(endpoint: OpenControlEndpoint.consultationTopic(id: id), completion: completion)
    }
    
    func getConsultationSlot(
        with id: String,
        completion: @escaping (Result<[ConsultationSlot], Error>) -> Void
    ) {
        networkManager.request(endpoint: OpenControlEndpoint.consultationSlot(id: id), completion: completion)
    }
    
    func bookConsultation(
        with data: BookSlotRequest,
        completion: @escaping (Result<Consultation, Error>) -> Void
    ) {
        networkManager.request(endpoint: OpenControlEndpoint.bookConsultation(bookConsultationRequest: data), completion: completion)
    }
}
