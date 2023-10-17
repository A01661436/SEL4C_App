//
//  ResultadosInfo.swift
//  Actividades
//
//  Created by Usuario on 16/10/23.
//

import Foundation

struct ResultadosInfo: Codable {
    let autocontrol: Int?
    let liderazgo: Int?
    let conciencia: Int?
    let innovacion: Int?
    
}

enum ResultadosInfoError: Error, LocalizedError {
    case itemNotFound
}
