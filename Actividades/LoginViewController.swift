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
        guard let usuario = usuarioTextField.text, let contrasena = contrasenaTextField.text, !usuario.isEmpty, !contrasena.isEmpty else {
            mostrarError(message: "Por favor completar todos los campos")
            return
        }
        
        let datosUsuario: [String: Any] = [
            "email": usuario,
            "contrasenia": contrasena
        ]
        
        Task {
            do {
                if let loginInfo = try await fetchLoginInfo(with: datosUsuario) {
                    handleLoginInfo(loginInfo)
                } else {
                    mostrarError(message: "Fallo en la solicitud de inicio de sesión")
                }
            } catch {
                print("Error en la solicitud de inicio de sesión: \(error)")
            }
        }
    }
    
    func handleLoginInfo(_ loginInfo: LoginResponse) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if loginInfo.status == "existe" {
                
                UserDefaults.standard.set(true, forKey: "isSignedIn")
                self.saveUserInfo(response: loginInfo)
                
                let identifier = (loginInfo.avance == -1) ? "diagInicial" : "MainTabBarController"
                let mainTabBarController = storyboard.instantiateViewController(identifier: identifier)

                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate,
                   let window = sceneDelegate.window {
                    window.rootViewController = mainTabBarController
                }
            } else {
                self.mostrarError(message: "Intente de nuevo")
            }

        }
    }
    
    func fetchLoginInfo(with datosUsuario: [String: Any]) async throws -> LoginResponse? {
        guard let url = URL(string: "http://18.222.144.45:8000/api/existe_usuario") else {
            return nil
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: datosUsuario, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return nil
        }
        
        let jsonDecoder = JSONDecoder()
        let loginInfo = try jsonDecoder.decode(LoginResponse.self, from: data)
        return loginInfo
    }
    
    func mostrarError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func saveUserInfo(response: LoginResponse) {
        UserDefaults.standard.set(response.nombre, forKey: "nombre")
        UserDefaults.standard.set(response.contrsenia, forKey: "contrasenia")
        UserDefaults.standard.set(response.usuarioID, forKey: "usuarioID")
        UserDefaults.standard.set(response.avance, forKey: "avance")
        UserDefaults.standard.set(response.email, forKey: "email")
        UserDefaults.standard.synchronize()
    }
}
