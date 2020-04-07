//
//  TextField.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 07/04/2020.
//

import UIKit

final class TextField: UITextField {
    
    // MARK: - Private properties
    
    private let leftViewPadding: CGFloat
    
    // MARK: - Object lifecycle
    
    init(leftViewPadding: CGFloat) {
        self.leftViewPadding = leftViewPadding
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITextView
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var paddedBounds = super.leftViewRect(forBounds: bounds)
        paddedBounds.origin.x = leftViewPadding
        return paddedBounds
    }
}
