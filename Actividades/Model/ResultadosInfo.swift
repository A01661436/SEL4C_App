//
//  ResultadosInfo.swift
//  Actividades
//
//  Created by Usuario on 16/10/23.
//

import Foundation

struct ResultadosInfo: Codable {
    let autocontrol_Promedio: Int?
    let liderazgo_Promedio: Int?
    let conciencia_Promedio: Int?
    let innovacion_Promedio: Int?
    
}

enum ResultadosInfoError: Error, LocalizedError {
    case itemNotFound
}
