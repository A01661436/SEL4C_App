//
//  RegistroResponse.swift
//  Actividades
//
//  Created by Usuario on 11/10/23.
//

import Foundation

struct RegistroResponse: Codable {
    let usuarioID: Int?
    let avance: Int?
    let nombre: String?
    let contrasenia: String?
    let email: String?
    let edad: Int?
    let pais: String?
    let institucion: String?
    let grado: String?
    let diciplina: String?
    
}
