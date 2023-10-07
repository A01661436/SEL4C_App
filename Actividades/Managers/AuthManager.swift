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
}
