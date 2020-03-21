//
//  UIView+Extensions.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 20/03/2020.
//

import UIKit

extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.topAnchor
      }
      return self.topAnchor
    }

    var safeLeadingAnchor: NSLayoutXAxisAnchor {
      if #available(iOS 11.0, *){
        return self.safeAreaLayoutGuide.leadingAnchor
      }
      return self.leadingAnchor
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
      if #available(iOS 11.0, *){
        return self.safeAreaLayoutGuide.trailingAnchor
      }
      return self.trailingAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
      if #available(iOS 11.0, *) {
        return self.safeAreaLayoutGuide.bottomAnchor
      }
      return self.bottomAnchor
    }
    
    func safeFit(_ subview: UIView) {
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.safeLeadingAnchor),
            subview.topAnchor.constraint(equalTo: self.safeTopAnchor),
            subview.trailingAnchor.constraint(equalTo: self.safeTrailingAnchor),
            subview.bottomAnchor.constraint(equalTo: self.safeBottomAnchor),
        ])
    }
}
