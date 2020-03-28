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
    
    var placeholder: String? {
        get {
            textField.placeholder
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    var isSecureTextEntry: Bool {
        get {
            textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
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
    
    // MARK: - Internal methods
    
    func validationFailed(_ errorMessage: String) {
        updateErrorState(validationFailed: true, errorMessage)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        textField.delegate = self
        addSubview(textField)
        addSubview(errorLabel)
    }
    
    private func updateErrorState(validationFailed: Bool, _ errorMessage: String? = nil) {
        textField.layer.borderColor = validationFailed
            ? UIColor.red.cgColor
            : UIColor.clear.cgColor
        textField.layer.borderWidth = validationFailed
            ? 1.0
            : 0
        errorLabel.text = errorMessage
        errorLabel.isHidden = validationFailed
            ? false
            : true
    }
}

// MARK: - UITextFieldDelegate

extension InputField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing?(textField)
        updateErrorState(validationFailed: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let result = delegate?.textFieldShouldReturn?(textField)
        textField.resignFirstResponder()
        return result ?? true
    }
}

// MARK: - Private extensions

private extension InputField {
    struct LayoutParameters {
        static let labelVerticalMargin: CGFloat = 4
    }
}
