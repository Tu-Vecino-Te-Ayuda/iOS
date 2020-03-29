//
//  User.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import Foundation

struct User: Decodable {
    let id: Int
    let email: String
    let phone: String
    let name: String
    let userTypeId: UserTypeId
    let address: String
    let city: String
    let state: String
    let zipCode: String
    let nearbyAreasId: NearbyAreasId
    let userStatusId: UserStatusId
    let associations: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, email, phone, name, userTypeId = "user_type_id", address, city, state, zipCode = "zip_code", nearbyAreasId = "nearby_areas_id", userStatusId = "user_status_id", associations
    }
        
    struct UserTypeId: Decodable {
        let id: Int
        let name: String
    }
    
    struct NearbyAreasId: Decodable {
        let id: Int
        let name: String
    }
    
    struct UserStatusId: Decodable {
        let id: Int
        let name: String
    }
}
