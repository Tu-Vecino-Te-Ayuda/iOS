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
    var error: ((Error) -> Void)?
    
    let title = "Tu vecino te ayuda"
    let requestorTitle = "NECESITO AYUDA"
    let volunteerTitle = "QUIERO AYUDAR"
    let loginTitle = "ACCEDER"
    
    // MARK: - Private properties
    
    private let service: ServiceType
    
    // MARK: - Object lifecycle
    
    init(service: ServiceType) {
        self.service = service
    }
    
    // MARK: - Internal methods
    
    func login(user: String, password: String) {
        let parameters = ["user": user, "password": password]
        service.login(parameters: parameters) { result in
            switch result {
            case .success(let response):
                self.logged?(response.user)
            case .failure(let error):
                self.error?(error)
            }
        }
    }
}
