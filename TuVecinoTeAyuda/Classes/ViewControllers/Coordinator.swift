//
//  Coordinator.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import UIKit

final class Coordinator {
    
    // MARK: - Private properties
    
    /// Navigation controller responsible of handling all app internal navigation
    private let navigationController: UINavigationController
    
    // MARK: - Object lifecycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal methods
    
    /// Starts the navigation
    func start() {
        showLoginViewController()
    }
    
    // MARK: - Private methods
    
    /// Create and show login view controller
    private func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        navigationController.setViewControllers([loginViewController], animated: false)
    }
    
    /// Create and show volunteer registration view controller
    private func showVolunteerRegister() {
//        let volunteerRegisterViewController = VolunteerRegisterViewController()
//        volunteerRegisterViewController.delegate = self
//        navigationController.present(volunteerRegisterViewController, animated: true)
        debugPrint("showVolunteerRegister")
    }
    
    /// Create and show requestor registration view controller
    private func showRequestorRegister() {
    //        let requestorRegisterViewController = RequestorRegisterViewController()
    //        requestorRegisterViewController.delegate = self
    //        navigationController.present(requestorRegisterViewController, animated: true)
            debugPrint("showRequestorRegister")
        }
}

// MARK: - Extensions

// MARK: LoginViewControllerDelegate

extension Coordinator: LoginViewControllerDelegate {
    func loginViewControllerRegisterVolunteer(_ sender: LoginViewController) {
        showVolunteerRegister()
    }
    
    func loginViewControllerRegisterRequestor(_ sender: LoginViewController) {
        showRequestorRegister()
    }
}
