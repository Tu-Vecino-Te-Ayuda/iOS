//
//  LoginResponse.swift
//  TuVecinoTeAyuda
//
//  Created by Kiszaner on 21/03/2020.
//

import Foundation

struct LoginResponse: Decodable {
    let token: String
    let user: User
}
