//
//  LoginViewModel.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import Foundation

final class LoginViewModel {
    
    // MARK: - Internal properties
    
    var logged: ((User) -> Void)?
    var operationInProgress: ((Bool) -> Void)?
    var error: ((APIError) -> Void)?
    
    let title = "Tu vecino te ayuda"
    let requestorTitle = "Necesito ayuda"
    let volunteerTitle = "Quiero ayudar"
    let loginTitle = "Iniciar sesión"
    
    // MARK: - Private properties
    
    private let service: ServiceType
    
    // MARK: - Object lifecycle
    
    init(service: ServiceType) {
        self.service = service
    }
    
    // MARK: - Internal methods
    
    func login(user: String, password: String) {
        let parameters = ["user": user, "password": password]
        operationInProgress?(true)
        service.login(parameters: parameters) { [weak self] result in
            guard let self = self else { return }
            self.operationInProgress?(false)
            switch result {
            case .success(let response):
                self.logged?(response.user)
            case .failure(let error):
                self.error?(error)
            }
        }
    }
}
