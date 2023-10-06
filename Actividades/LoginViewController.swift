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
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func loginAction(_ sender: Any) {
        // Obtener el texto ingresado en los campos de texto
        guard let usuario = usuarioTextField.text, let contrasena = contrasenaTextField.text else
        {
            return
        }
        
        let datosUsuario: [String: Any] = [
            "username": usuarioTextField.text!,
            "password": contrasenaTextField.text!
            
        ]
        
        DispatchQueue.main.async {
            AuthManager.shared.loginUsuario(with: datosUsuario) { success in
                if success {
                    // Registro exitoso, puedes hacer algo aquí si es necesario
                    print("Login exitoso")
                } else {
                    // Fallo en el registro, puedes hacer algo aquí si es necesario
                    print("Fallo en el login")
                }
            }
        }
        
        print(datosUsuario)
        
        
        
        
    }
}
