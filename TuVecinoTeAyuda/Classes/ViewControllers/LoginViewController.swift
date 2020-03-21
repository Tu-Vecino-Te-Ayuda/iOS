//
//  LoginViewController.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 20/03/2020.
//

import UIKit

protocol LoginViewControllerDelegate {
    func loginViewControllerRegisterVolunteer(_ sender: LoginViewController)
    func loginViewControllerRegisterRequestor(_ sender: LoginViewController)
}

final class LoginViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: Images.background)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = LayoutParameters.spacing
        return stackView
    }()
    
    var registerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = LayoutParameters.spacing
        return stackView
    }()
    
    var heroImageView: UIImageView = {
        let imageView = UIImageView(image: Images.hero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var userField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Teléfono o email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    
    var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Iniciar sesión", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    var volunteerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Quiero ayudar", for: .normal)
        button.addTarget(self, action: #selector(volunteerRegisterTapped), for: .touchUpInside)
        return button
    }()
    
    var requestorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Necesito ayuda", for: .normal)
        button.addTarget(self, action: #selector(requestorRegisterTapped), for: .touchUpInside)
        return button
    }()
    
    var delegate: LoginViewControllerDelegate?
    
    // MARK: - Object lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        title = "Tu vecino te ayuda"
        userField.delegate = self
        passwordField.delegate = self
        configureTapGesture()
    }
    
    private func setupLayout() {
        view.addSubview(backgroundImageView)
        view.safeFit(backgroundImageView)
        view.addSubview(heroImageView)
        view.addSubview(loginStackView)
        view.addSubview(registerStackView)
        
        loginStackView.addArrangedSubview(userField)
        loginStackView.addArrangedSubview(passwordField)
        loginStackView.addArrangedSubview(loginButton)
        registerStackView.addArrangedSubview(volunteerButton)
        registerStackView.addArrangedSubview(requestorButton)
        
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: LayoutParameters.margin),
            heroImageView.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: LayoutParameters.margin),
            heroImageView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -LayoutParameters.margin),
            loginStackView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: LayoutParameters.spacing),
            loginStackView.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: LayoutParameters.spacing),
            loginStackView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -LayoutParameters.spacing),
            registerStackView.leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: LayoutParameters.margin),
            registerStackView.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: LayoutParameters.verticalSpacing),
            registerStackView.trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -LayoutParameters.margin),
        ])
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleViewTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleViewTap() {
        view.endEditing(true)
    }
    
    @objc
    private func loginTapped() {
        loginButton.endEditing(true)
        // Do login
    }
    
    @objc
    private func requestorRegisterTapped() {
        // Go to Requesto form
        delegate?.loginViewControllerRegisterRequestor(self)
    }
    
    @objc
    private func volunteerRegisterTapped() {
        // Go to Requesto form
        delegate?.loginViewControllerRegisterVolunteer(self)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Private extensions

private extension LoginViewController {
    struct LayoutParameters {
        static let spacing: CGFloat = 16.0
        static let verticalSpacing: CGFloat = 40.0
        static let margin: CGFloat = 16.0
    }
}
