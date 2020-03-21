//
//  Province.swift
//  TuVecinoTeAyuda
//
//  Created by Alberto Vivar Arribas on 21/03/2020.
//  Copyright © 2020 Rodrigo Jurado. All rights reserved.
//

import Foundation

/// One of the province of the nation.
struct Province: Decodable {
    /// Identifier of the provice. The first two digits of the postal code are to identify the province.
    let identifier: String
    
    /// Name of the province.
    let name: String
    
    /// The list of municipalities that a provice owns.
    let municipalities: [Municipality]
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "nm"
        case municipalities = "cities"
    }
    
    /// One municipality part of a province.
    struct Municipality: Decodable {
        /// Identifier of the municipality. It has its own identifier.
        let identifier: String
        
        /// Name of the municipality.
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case name = "nm"
        }
    }
}

extension Array where Element == Province {
    /// Flattens the list of all municipalities contained in all the provinces.
    func getAllMunicipalities() -> [Province.Municipality] {
        return self.flatMap {$0.municipalities}
    }
}
