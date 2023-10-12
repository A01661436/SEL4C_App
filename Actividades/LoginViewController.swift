//
//  LoginViewController.swift
//  Actividades
//
//  Created by Usuario on 28/09/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contrasenaTextField: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var registrateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView.layer.cornerRadius = 30
        self.loginView.clipsToBounds = true
        

        self.loginView.layer.shadowColor = UIColor.black.cgColor
        self.loginView.layer.shadowOpacity = 0.5
        self.loginView.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.loginView.layer.shadowRadius = 1
        self.loginView.layer.masksToBounds = false
        
        contrasenaTextField.isSecureTextEntry = true
        
   
    }
    
    
    @IBAction func registrateAction(_ sender: Any) {
        
        performSegue(withIdentifier: "showRegistro", sender: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        // Obtener el texto ingresado en los campos de texto
        guard let usuario = usuarioTextField.text, let contrasena = contrasenaTextField.text, !usuario.isEmpty, !contrasena.isEmpty else
        {
            mostrarError(message: "Por favor completar todos los campos")
            return
        }
        
        let datosUsuario: [String: Any] = [
            "email": usuario,
            "contrasenia": contrasena
            
        ]
        
        let am = AuthManager()
        DispatchQueue.main.async {
            am.loginUsuario(with: datosUsuario) { success in
                if success {
                    // Inicio de sesión exitoso
                    
                    print("Login exitoso")
                    
                    // Realizar la transición a MainTabBarController solo cuando el inicio de sesión sea exitoso
                    DispatchQueue.main.async {
                        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
                        let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                        let window = sceneDelegate.window
                        window?.rootViewController = mainTabBarController
                    }
                } else {
                    print("Fallo en el login")
                    DispatchQueue.main.async {
                        self.mostrarError(message: "Fallo en el inicio de sesión")
                    }
                }
            }
        }
        
        print(datosUsuario)
    }
    
    // Función para mostrar una alerta de error
    func mostrarError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
