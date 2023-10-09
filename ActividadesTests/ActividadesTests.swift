//
//  ActividadesTests.swift
//  ActividadesTests
//
//  Created by Diego Martell on 04/10/23.
//

import XCTest
@testable import Actividades

final class ActividadesTests: XCTestCase {
    func testCP_01_LogIn_Success() throws {
        let authManager = AuthManager()
        let datosUsuario: [String: Any] = [
            "username": "testUser",
            "password": "testPassword"
        ]
        authManager.loginUsuario(with: datosUsuario) { success in
            XCTAssert(success, "User login failed.")
        }
    }
    
    func testCP_02_LogIn_Failed() throws {
        let authManager = AuthManager()
        let datosUsuario: [String: Any] = [
            "username": "",
            "password": ""
        ]
        authManager.loginUsuario(with: datosUsuario) { success in
            XCTAssertFalse(success, "User login should fail with empty credentials.")
        }
    }
    
    func testCP_03_Registro_Success() throws {
        let rm = RegistroManager()
        let datosUsuario: [String: Any] = [
            "nombre": "DiegoM",
            "contrasenia": "YOLO1234d",
            "email": "jdiegomf@hotmail.com",
            "avance": 0,
            "genero": "Femenino",
            "edad": 17,
            "pais": "México",
            "institucion": "TEC",
            "grado": "prepa",
            "diciplina": "Humanidades"
        ]
        rm.registraUsuario(with: datosUsuario) { success in
            XCTAssert(success, "User registration failed.")
        }
    }
    
    func testCP_04_Registro_Failed() throws {
        let rm = RegistroManager()
        let datosUsuario: [String: Any] = [
            "contrasenia": "YOLO1234d",
            "email": "jdiegomf@hotmail.com",
            "avance": 0,
            "genero": "Femenino",
            "edad": 17,
            "pais": "México",
            "institucion": "TEC",
            "grado": "prepa",
            "diciplina": "Humanidades"
        ]
        rm.registraUsuario(with: datosUsuario) { success in
                XCTAssertFalse(success, "Expected registration to fail due to missing 'nombre', but it succeeded.")
            }
    }
    
    
    func testCP_05_EncuestaInicFin_Success() throws {
        
    }
    
    func testCP_06_EncuestaInicFin_Failed() throws {
        
    }
    
    func testCP_07_LogOut_Success() throws {
        var perfilVC: PerfilViewController!

        func setUp() {
            super.setUp()
            perfilVC = PerfilViewController()
        }

        func tearDown() {
            perfilVC = nil
            super.tearDown()
        }

        func testCP_02_Logout_Success() throws {
            UserDefaults.standard.set(true, forKey: "isSignedIn")
            perfilVC.logout()
            
            XCTAssertNil(UserDefaults.standard.object(forKey: "isSignedIn"), "User should be logged out.")
        }
    }
    
    func testCP_08_LogOut_Failed() throws {
        var perfilVC: PerfilViewController!

        func setUp() {
            super.setUp()
            perfilVC = PerfilViewController()
        }

        func tearDown() {
            perfilVC = nil
            super.tearDown()
        }

        func testCP_03_Logout_Failure() throws {
            UserDefaults.standard.removeObject(forKey: "isSignedIn")
            let didLogout = perfilVC.logout2()
            
            XCTAssertFalse(didLogout, "Logout should fail if the user is not logged in.")
        }
    }
    
    func testCP_09_Progreso_Success() throws {
        
    }
    
    func testCP_10_Progreso_Failed() throws {
        
    }
    
    

}
