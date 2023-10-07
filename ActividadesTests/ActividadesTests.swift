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
        
    }
    
    func testCP_02_LogIn_Failed() throws {
        
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
    
    func testCP_05_SubirArchivo_Success() throws {
        
    }
    
    func testCP_06_SubirArchivo_Failed() throws {
        
    }
    
    func testCP_07_EncuestaInicFin_Success() throws {
        
    }
    
    func testCP_08_EncuestaInicFin_Failed() throws {
        
    }
    
    func testCP_09_LogOut_Success() throws {
        
    }
    
    func testCP_10_LogOut_Failed() throws {
        
    }
    
    func testCP_11_Progreso_Success() throws {
        
    }
    
    func testCP_12_Progreso_Failed() throws {
        
    }
    
    

}
