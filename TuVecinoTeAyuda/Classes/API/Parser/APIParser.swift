//
//  APIParser.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import Foundation

struct APIParser {
    static let decoder = {
        return JSONDecoder()
    }()
    
    static func parse<T: Decodable>(_ data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}
