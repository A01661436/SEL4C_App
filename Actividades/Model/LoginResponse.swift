//
//  LoginResponse.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import Foundation

struct LoginResponse: Codable {
    let status: String
    let nombre: String?
    let contrsenia: String?
    let usuarioID: Int?
    let avance: Int?
    let email: String?
}
