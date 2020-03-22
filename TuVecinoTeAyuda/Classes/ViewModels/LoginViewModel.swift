//
//  LoginViewModel.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import Foundation

final class LoginViewModel {
    
    private let service: ServiceType
    
    init(service: ServiceType) {
        self.service = service
    }
    
    func login() {
        let parameters = ["user": "sergyzen@gmail.com", "password": "asdfasdf123"]
        service.login(parameters: parameters) { result in
            switch result {
            case .success(let response):
                debugPrint(response)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
