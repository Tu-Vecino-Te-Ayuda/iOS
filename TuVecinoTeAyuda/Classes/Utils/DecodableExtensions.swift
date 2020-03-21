//
//  DecodableExtensions.swift
//  TuVecinoTeAyuda
//
//  Created by Alberto Vivar Arribas on 21/03/2020.
//  Copyright © 2020 Rodrigo Jurado. All rights reserved.
//

import Foundation

extension Decodable {
    static func deserialize(_ file: File) -> Self {
        let fileAttributes = file.translate()
        let resourceURL = Bundle.main.url(forResource: fileAttributes.filename, withExtension: fileAttributes.extension.rawValue)!
        let data: Data = try! .init(contentsOf: resourceURL)
        return try! JSONDecoder.init().decode(Self.self, from: data)
    }
}
