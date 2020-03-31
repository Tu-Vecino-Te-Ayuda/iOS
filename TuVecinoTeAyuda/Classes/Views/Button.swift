//
//  Button.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 31/03/2020.
//

import UIKit

final class Button: UIButton {
    
    // MARK: - Internal types
    
    enum ButtonType {
        case primary
        case secondary
    }
    
    // MARK: - Private properties
    
    /// Background color used for normal state
    private let normalBackgroundColor: UIColor
    
    /// Background color used for disabled state
    private let disabledBackgroundColor: UIColor
    
    /// Background color used for highlighted state
    private let highlightedBackgroundColor: UIColor
    
    /// Text color used for normal state
    private let textColor: UIColor
    
    // MARK: - Object lifecycle
    
    init(buttonType: Button.ButtonType) {
        switch buttonType {
        case .primary:
            self.normalBackgroundColor = Constants.Colors.green
            self.highlightedBackgroundColor = Constants.Colors.darkGreen
            self.disabledBackgroundColor = .gray
            textColor = .white
        case .secondary:
            self.normalBackgroundColor = Constants.Colors.main
            self.highlightedBackgroundColor = Constants.Colors.darkMain
            self.disabledBackgroundColor = .gray
            textColor = .black
        }
        super.init(frame: .zero)
        backgroundColor = normalBackgroundColor
        layer.cornerRadius = LayoutParameters.cornerRadius
        setTitleColor(textColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIButton
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? normalBackgroundColor : disabledBackgroundColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : normalBackgroundColor
        }
    }
}

// MARK: - Private extensions

private extension Button {
    struct LayoutParameters {
        static let cornerRadius: CGFloat = 20
    }
}
