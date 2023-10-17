//
//  ActividadesInfo.swift
//  Actividades
//
//  Created by Usuario on 16/10/23.
//

import Foundation

struct ActividadesInfo: Codable {
    let identificacion: Bool?
    let investigacion: Bool?
    let ideacion: Bool?
    let socializacion: Bool?
    
}

enum ActividadesInfoError: Error, LocalizedError {
    case itemNotFound
}
