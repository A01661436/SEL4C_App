//
//  AuthManager.swift
//  Actividades
//
//  Created by Usuario on 30/09/23.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    var isSignedIn: Bool {
        return true
    }
}
