//
//  LoginViewController.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 20/03/2020.
//

import UIKit
import SwiftValidator

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
    
    var loginContainerView: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
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
    
    var userField: InputField = {
        let inputField = InputField(textFieldHeight: 50)
        inputField.placeholder = "Teléfono o email"
        return inputField
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
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = Constants.Colors.green.cgColor
        button.setTitleColor(.white, for: .normal)
        button.setTitle("ACCEDER", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    var volunteerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = Constants.Colors.main.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("QUIERO AYUDAR", for: .normal)
        button.addTarget(self, action: #selector(volunteerRegisterTapped), for: .touchUpInside)
        return button
    }()
    
    var requestorButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.layer.backgroundColor = Constants.Colors.main.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("NECESITO AYUDA", for: .normal)
        button.addTarget(self, action: #selector(requestorRegisterTapped), for: .touchUpInside)
        return button
    }()
    
    let validator = Validator()
    var delegate: LoginViewControllerDelegate?
    
    // MARK: - Object lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        title = "Tu vecino te ayuda"
//        self.userField.textField.delegate = self
        self.passwordField.delegate = self
        // Validation Rules are evaluated from left to right.
        validator.registerField(userField, errorLabel: userField.errorLabel, rules: [RequiredRule(message: "Campo necesario"), EmailRule(message: "Introduce tu email")])
        validator.registerField(passwordField, rules: [PasswordRule(message: "Introduce tu constraseña")])

//        // You can pass in error labels with your rules
//        // You can pass in custom error messages to regex rules (such as ZipCodeRule and EmailRule)
//        validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
//
//        // You can validate against other fields using ConfirmRule
//        validator.registerField(emailConfirmTextField, errorLabel: emailConfirmErrorLabel, rules: [ConfirmationRule(confirmField: emailTextField)])
//
//        // You can now pass in regex and length parameters through overloaded contructors
//        validator.registerField(phoneNumberTextField, errorLabel: phoneNumberErrorLabel, rules: [RequiredRule(), MinLengthRule(length: 9)])
//        validator.registerField(zipcodeTextField, errorLabel: zipcodeErrorLabel, rules: [RequiredRule(), ZipCodeRule(regex = "\\d{5}")])

//         You can unregister a text field if you no longer want to validate it
//        validator.unregisterField(fullNameTextField)
        self.configureTapGesture()
    }
    
    private func setupLayout() {
        self.view.addSubview(self.backgroundImageView)
        self.view.safeFit(self.backgroundImageView)
        self.view.addSubview(self.heroImageView)
        self.view.addSubview(self.loginContainerView)
        self.view.addSubview(self.registerStackView)
        
        self.loginContainerView.addSubview(self.loginStackView)
        
        self.loginStackView.addArrangedSubview(self.userField)
//        self.loginStackView.addArrangedSubview(self.userErrorLabel)
        self.loginStackView.addArrangedSubview(self.passwordField)
        self.loginStackView.addArrangedSubview(self.loginButton)
        self.registerStackView.addArrangedSubview(self.volunteerButton)
        self.registerStackView.addArrangedSubview(self.requestorButton)
        
        NSLayoutConstraint.activate([
            // Position the header image.
            self.heroImageView.leadingAnchor.constraint(equalTo: self.view.safeLeadingAnchor, constant: LayoutParameters.margin),
            self.heroImageView.topAnchor.constraint(equalTo: self.view.safeTopAnchor, constant: LayoutParameters.margin),
            self.heroImageView.trailingAnchor.constraint(equalTo: self.view.safeTrailingAnchor, constant: -LayoutParameters.margin),
            
            // Then, set the login container.
            self.loginContainerView.topAnchor.constraint(equalTo: self.heroImageView.bottomAnchor, constant: LayoutParameters.spacing),
            self.loginContainerView.leadingAnchor.constraint(equalTo: self.view.safeLeadingAnchor, constant: LayoutParameters.spacing),
            self.loginContainerView.trailingAnchor.constraint(equalTo: self.view.safeTrailingAnchor, constant: -LayoutParameters.spacing),
            
            // Some padding from the container view to the stack view.
            self.loginStackView.leadingAnchor.constraint(equalTo: self.loginContainerView.leadingAnchor, constant: 15),
            self.loginStackView.topAnchor.constraint(equalTo: self.loginContainerView.topAnchor, constant: 20),
            self.loginContainerView.trailingAnchor.constraint(equalTo: self.loginStackView.trailingAnchor, constant: 15),
            self.loginContainerView.bottomAnchor.constraint(equalTo: self.loginStackView.bottomAnchor, constant: 20),
            
            // Adjust the size of the text fields.
            self.userField.widthAnchor.constraint(equalTo: self.loginStackView.widthAnchor),
            self.passwordField.widthAnchor.constraint(equalTo: self.loginStackView.widthAnchor),
//            self.userField.heightAnchor.constraint(equalToConstant: 50),
            self.passwordField.heightAnchor.constraint(equalToConstant: 50),
            self.loginButton.heightAnchor.constraint(equalToConstant: 60),
            self.loginStackView.widthAnchor.constraint(equalTo: self.loginButton.widthAnchor, multiplier: 1, constant: 95),
            
            // Then, the register elements.
            self.registerStackView.topAnchor.constraint(equalTo: self.loginContainerView.bottomAnchor, constant: LayoutParameters.verticalSpacing),
            self.registerStackView.leadingAnchor.constraint(equalTo: self.view.safeLeadingAnchor, constant: LayoutParameters.margin),
            self.registerStackView.trailingAnchor.constraint(equalTo: self.view.safeTrailingAnchor, constant: -LayoutParameters.margin),
            
            // Setup of the register buttons.
            self.requestorButton.widthAnchor.constraint(equalTo: self.loginButton.widthAnchor, multiplier: 1, constant: 30),
            self.volunteerButton.widthAnchor.constraint(equalTo: self.requestorButton.widthAnchor),
            self.requestorButton.heightAnchor.constraint(equalTo: self.loginButton.heightAnchor),
            self.volunteerButton.heightAnchor.constraint(equalTo: self.requestorButton.heightAnchor),
        ])
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleViewTap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleViewTap() {
        self.view.endEditing(true)
    }
    
    @objc
    private func loginTapped() {
        self.loginButton.endEditing(true)
        // Do login
        validator.validate(self)
    }
    
    @objc
    private func requestorRegisterTapped() {
        // Go to Requesto form
        self.delegate?.loginViewControllerRegisterRequestor(self)
    }
    
    @objc
    private func volunteerRegisterTapped() {
        // Go to Requesto form
        self.delegate?.loginViewControllerRegisterVolunteer(self)
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
}

// MARK: - ValidatorDelegate

extension LoginViewController: ValidationDelegate {
    func validationSuccessful() {
        debugPrint("validation succedded")
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        errors.forEach { (field, error) in
            guard let field = field as? InputField else {
                return
            }
//        }
//        for (field, error) in validator.errors {
            field.validationFailed(error.errorMessage)
        }
    }
}

// MARK: - Private extensions

private extension LoginViewController {
    struct LayoutParameters {
        static let spacing: CGFloat = 10.0
        static let verticalSpacing: CGFloat = 40.0
        static let margin: CGFloat = 16.0
    }
}
