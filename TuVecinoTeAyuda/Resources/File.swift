//
//  Files.swift
//  TuVecinoTeAyuda
//
//  Created by Alberto Vivar Arribas on 21/03/2020.
//  Copyright © 2020 Rodrigo Jurado. All rights reserved.
//

import Foundation

enum File {
    case municipalities
    
    enum Extension: String {
        case json = "json"
    }
    
    typealias Filename = (filename: String, extension: Extension)
    
    func translate() -> Filename {
        switch self {
        case .municipalities:
            return ("municipalities", .json)
        }
    }
}
