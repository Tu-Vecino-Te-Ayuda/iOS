//
//  Coordinator.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import UIKit

class Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginViewController()
    }
    
    private func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        navigationController.setViewControllers([loginViewController], animated: false)
    }
    
    private func showVolunteerRegister() {
//        let volunteerRegisterViewController = VolunteerRegisterViewController()
//        volunteerRegisterViewController.delegate = self
//        navigationController.present(volunteerRegisterViewController, animated: true)
        debugPrint("showVolunteerRegister")
    }
    
    private func showRequestorRegister() {
    //        let requestorRegisterViewController = RequestorRegisterViewController()
    //        requestorRegisterViewController.delegate = self
    //        navigationController.present(requestorRegisterViewController, animated: true)
            debugPrint("showRequestorRegister")
        }
}

// MARK: - LoginViewControllerDelegate

extension Coordinator: LoginViewControllerDelegate {
    func loginViewControllerRegisterVolunteer(_ sender: LoginViewController) {
        showVolunteerRegister()
    }
    
    func loginViewControllerRegisterRequestor(_ sender: LoginViewController) {
        showRequestorRegister()
    }
}
