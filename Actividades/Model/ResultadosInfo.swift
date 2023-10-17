//
//  ResultadosInfo.swift
//  Actividades
//
//  Created by Usuario on 16/10/23.
//

import Foundation

struct ResultadosInfo: Codable {
    let Autocontrol: Float?
    let Liderazgo: Float?
    let Conciencia: Float?
    let Innovacion: Float?
    
}

enum ResultadosInfoError: Error, LocalizedError {
    case itemNotFound
}
