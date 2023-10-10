//
//  PerfilViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class PerfilViewController: UIViewController{
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contrasenaLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nombre = UserDefaults.standard.string(forKey: "nombre") {
            nombreLabel.text = nombre
        } else {
            nombreLabel.text = "Desconocido"
        }
        
        if let email = UserDefaults.standard.string(forKey: "email") {
            emailLabel.text = email
        } else {
            emailLabel.text = "Desconocido"
        }
        
        if let contrasena = UserDefaults.standard.string(forKey: "nombre") {
            contrasenaLabel.text = "*********"
        } else {
            contrasenaLabel.text = "Desconocido"
        }
    }
    
    @IBOutlet weak var nombreLabel: UILabel!
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        print("logout")
        // Eliminar la información del usuario de UserDefaults
        UserDefaults.standard.removeObject(forKey: "isSignedIn")
        UserDefaults.standard.removeObject(forKey: "nombre")
        UserDefaults.standard.removeObject(forKey: "contrasenia")
        UserDefaults.standard.removeObject(forKey: "usuarioID")
        UserDefaults.standard.removeObject(forKey: "avance")
        UserDefaults.standard.removeObject(forKey: "email")
        
        
        UserDefaults.standard.synchronize()
        
        let loginViewController = UIStoryboard(name: K.StoryBoardID.main, bundle: nil).instantiateViewController(identifier: K.StoryBoardID.loginViewController)
        
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,let window = sceneDelegate.window {
            window.rootViewController = loginViewController
            
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
    }
    
    
    @IBAction func nombreAction(_ sender: Any) {
        let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nombreViewController")
        vistaDestino.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vistaDestino, animated: true)
        }
        
    }
    
    
}

//Para prueba exitosa
extension PerfilViewController {
    func logout() {
        // Eliminar la información del usuario de UserDefaults
        UserDefaults.standard.removeObject(forKey: "isSignedIn")
        UserDefaults.standard.removeObject(forKey: "nombre")
        UserDefaults.standard.removeObject(forKey: "contrasenia")
        UserDefaults.standard.removeObject(forKey: "usuarioID")
        UserDefaults.standard.removeObject(forKey: "avance")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.synchronize()
    }
}

//Para prueba fallida
extension PerfilViewController {
    func logout2() -> Bool {
        guard UserDefaults.standard.object(forKey: "isSignedIn") != nil else {
            // User is not logged in
            return false
        }
        
        // Eliminar la información del usuario de UserDefaults
        UserDefaults.standard.removeObject(forKey: "isSignedIn")
        UserDefaults.standard.removeObject(forKey: "nombre")
        UserDefaults.standard.removeObject(forKey: "contrasenia")
        UserDefaults.standard.removeObject(forKey: "usuarioID")
        UserDefaults.standard.removeObject(forKey: "avance")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.synchronize()
        
        return true
    }
}
