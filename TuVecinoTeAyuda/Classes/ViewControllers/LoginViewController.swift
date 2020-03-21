//
//  LoginViewController.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 20/03/2020.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        let button = UIButton()
        button.setTitle("Iniciar sesión", for: .normal)
        return button
    }()
    
    var volunteerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Quiero ayudar", for: .normal)
        return button
    }()
    
    var requestorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Necesito ayuda", for: .normal)
        return button
    }()
    
    // MARK: - Private properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    func setupView() {
        title = "Tu vecino te ayuda"
        userField.delegate = self
        passwordField.delegate = self
        configureTapGesture()
    }
    
    func setupLayout() {
        view.addSubview(backgroundImageView)
        view.safeFit(backgroundImageView)
        view.addSubview(heroImageView)
        view.addSubview(loginStackView)
        
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
        ])
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleTap() {
        view.endEditing(true)
    }
    
    private func loginPressed() {
        loginButton.endEditing(true)
        // Do login
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
        static let margin: CGFloat = 16.0
    }
}
