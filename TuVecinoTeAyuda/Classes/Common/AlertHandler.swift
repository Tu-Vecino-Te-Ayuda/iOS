//
//  AlertHandler.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 02/04/2020.
//

import UIKit

protocol AlertHandler {
    func showAlert(title: String, message: String, buttonTitle: String, completionHandler: (() -> Void)?)
}

extension AlertHandler where Self: UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String, completionHandler: (() -> Void)? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completionHandler?()
        }
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
}
