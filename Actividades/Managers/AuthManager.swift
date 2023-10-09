//
//  AuthManager.swift
//  Actividades
//
//  Created by Diego Martell on 05/10/23.
//

import Foundation

class AuthManager {

    var isSignedIn: Bool {
        return true
    }
    
    public func loginUsuario(with datosUsuario: [String: Any], completion: @escaping ((Bool)-> Void))
    {
        let url = URL(string: "http://18.222.144.45:8000/api/existe_usuario")!
        
        // Convertir los datos del usuario a JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: datosUsuario, options: []) else {
            completion(false)
            return
        }
        
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        // Establecer el encabezado para indicar que estamos enviando datos JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let result = try JSONDecoder().decode(LoginResponse.self, from: data)
                if result.status == "existe"
                {
                    UserDefaults.standard.set(true, forKey: "isSignedIn")
                    self.saveUserInfo(response: result)
                    completion(true)
                    
                } else
                {
                    completion(false)
                    
                }
                
                print("SUCCESS: \(json)")
                
            } catch{
                print(error)
                completion(false)
                
            }
        }
        task.resume()
    }
    
    struct LoginResponse: Codable {
        let status: String
        let nombre: String?
        let contrsenia: String?
        let usuarioID: Int?
        let avance: Int?
        let email: String?
    }
    
    // Función para guardar la información del usuario en UserDefaults
    private func saveUserInfo(response: LoginResponse) {
        UserDefaults.standard.set(response.nombre, forKey: "nombre")
        UserDefaults.standard.set(response.contrsenia, forKey: "contrasenia")
        UserDefaults.standard.set(response.usuarioID, forKey: "usuarioID")
        UserDefaults.standard.set(response.avance, forKey: "avance")
        UserDefaults.standard.set(response.email, forKey: "email")
        UserDefaults.standard.synchronize()
    }
    
}
