//
//  InputField.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 26/03/2020.
//

import Foundation
import UIKit
import SwiftValidator

final class InputField: UIView, Validatable {
    
    // MARK: - Internal properties
    
    var shouldSetupConstraints = true
    let textFieldHeight: CGFloat
    weak var delegate: UITextFieldDelegate?
    
    var validationText: String {
        return textField.text ?? ""
    }
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()
    
    private lazy var errorLabelConstraints: [NSLayoutConstraint] = {
        return [
            errorLabel.leadingAnchor.constraint(equalTo: self.textField.textInputView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: self.textField.textInputView.trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: LayoutParameters.labelVerticalMargin),
            errorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -LayoutParameters.labelVerticalMargin),
        ]
    }()
    
    // MARK: - Object lifecycle
    
    init(textFieldHeight: CGFloat) {
        self.textFieldHeight = textFieldHeight
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIView
    
    override func updateConstraints() {
        if shouldSetupConstraints {
            NSLayoutConstraint.activate(errorLabelConstraints)
            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                textField.topAnchor.constraint(equalTo: self.topAnchor),
                textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                textField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            ])
            
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    override func becomeFirstResponder() -> Bool {
        textField.becomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
        return super.resignFirstResponder()
    }
    
    // MARK: - Internal methods
    
    /// Use this method to set a user visible error message in the error label associated to this input field
    /// - Parameter errorMessage: Error message intended to be read by the user
    func validationFailed(_ errorMessage: String) {
        updateErrorState(validationFailed: true, errorMessage)
    }
    
    /// Validates a text field content according validation rules from the validator
    /// - Parameter validator: Validator used to perform the validation
    /// - Parameter completionHandler: Callback performed if validation was successful
    func validate(usingValidator validator: Validator, completionHandler: @escaping () -> Void) {
        validator.validateField(self) { (validationError) in
            guard validationError == nil else {
                updateErrorState(validationFailed: true, validationError?.errorMessage)
                return
            }
            updateErrorState()
            completionHandler()
        }
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        textField.delegate = self
        addSubview(textField)
        addSubview(errorLabel)
    }
    
    /// Updates the error label associated to this input field based on the input validation
    /// - Parameters:
    ///   - validationFailed: `true` if the input field validation has failed. Default value is`false`
    ///   - errorMessage: Error message intended to be read by the user
    private func updateErrorState(validationFailed: Bool = false, _ errorMessage: String? = nil) {
        textField.layer.borderColor = validationFailed ? UIColor.red.cgColor : UIColor.clear.cgColor
        textField.layer.borderWidth = validationFailed ? 1.0 : 0
        errorLabel.text = errorMessage
        errorLabel.isHidden = !validationFailed
    }
}

// MARK: - UITextFieldDelegate

extension InputField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing?(textField)
        updateErrorState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let result = delegate?.textFieldShouldReturn?(textField)
        return result ?? true
    }
}

// MARK: - Private extensions

private extension InputField {
    struct LayoutParameters {
        static let labelVerticalMargin: CGFloat = 4
    }
}
