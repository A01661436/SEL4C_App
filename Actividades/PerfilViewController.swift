//
//  PerfilViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class PerfilViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nombre = UserDefaults.standard.string(forKey: "nombre") {
            nombreLabel.text = nombre
        } else {
            nombreLabel.text = "Desconocido"
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
    
    
}
