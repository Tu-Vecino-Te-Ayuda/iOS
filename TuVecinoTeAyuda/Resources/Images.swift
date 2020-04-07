//
//  Images.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import UIKit

struct Images {
    static let background = Images.byName("Background")
    static let hero = Images.byName("Hero")
    static let user = Images.byName("User")
    static let lock = Images.byName("Lock")
    
    static func byName(_ name: String) -> UIImage? {
        return UIImage(named: name)
    }
}
