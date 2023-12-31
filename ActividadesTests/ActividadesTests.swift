//
//  ActividadesTests.swift
//  ActividadesTests
//
//  Created by Diego Martell on 04/10/23.
//

import XCTest
@testable import Actividades

final class ActividadesTests: XCTestCase {
    //Se definen variables para las diferentes pruebas prueba
    var perfilVC: PerfilViewController!
    
    override func setUp() {
        super.setUp()
        perfilVC = PerfilViewController()
    }

    override func tearDown() {
        perfilVC = nil
        super.tearDown()
    }
    
    //Comienzan los casos de prueba
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
    
    func testCP_07_LogOut_Success() throws {
        UserDefaults.standard.set(true, forKey: "isSignedIn")
        perfilVC.logout()
            
        XCTAssertNil(UserDefaults.standard.object(forKey: "isSignedIn"), "User should be logged out.")
    }
    
    func testCP_08_LogOut_Failed() throws {
        UserDefaults.standard.removeObject(forKey: "isSignedIn")
        let didLogout = perfilVC.logout2()
        
        XCTAssertFalse(didLogout, "Logout should fail if the user is not logged in.")
    }
    
    

}

class CutionarioViewControllerTests: XCTestCase {
    
    var sut: CutionarioViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "CutionarioViewController") as? CutionarioViewController
        sut.loadViewIfNeeded()
        
        let sampleQuestions = [
            Question(id: 1, text: "Sample Question 1"),
            Question(id: 2, text: "Sample Question 2")
        ]
        sut.engine.initialize(q: sampleQuestions)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCP_05_EncuestaInicFin_Success() {
        sut.userResponses.responses.removeAll()
        
        let button = UIButton()
        button.titleLabel?.text = "Ni de acuerdo ni desacuerdo"
        sut.userAnswer(button)
        
        XCTAssertEqual(sut.userResponses.responses.count, 1, "Expected one response to be added after clicking the button.")
    }
    
    func testCP_06_EncuestaInicFin_Failed() {
        sut.engine.questions = []
        
        XCTAssertEqual(sut.engine.questions.count, 0, "Expected questions to be empty, which is an invalid state.")
    }
}
