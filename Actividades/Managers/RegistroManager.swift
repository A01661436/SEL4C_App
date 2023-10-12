//
//  RegistroManager.swift
//  Actividades
//
//  Created by Diego Martell on 05/10/23.
//

import Foundation
import UIKit

class RegistroManager {

    public func registraUsuario(with datosUsuario: [String: Any], completion: @escaping ((Bool)-> Void))
    {
        let urlRegistro = URL(string: "http://18.222.144.45:8000/api/users/")!
        
        // Convertir los datos del usuario a JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: datosUsuario, options: []) else {
            completion(false)
            return
        }
        
        
        
        var request = URLRequest(url: urlRegistro)
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
                if let result = try? JSONDecoder().decode(RegistroResponse.self, from: data) {
                    
                    
                    print("SUCCESS: \(json)")
                    UserDefaults.standard.set(false, forKey: "isSignedIn")
                    self.saveUserInfo(response: result)
                    completion(true)
                } else {
                    print("Failed to decode RegistroResponse")
                    completion(false)
                }
 
            } catch{
                print(error)
                completion(false)
                
            }
        }
        task.resume()
    }
    
    private func saveUserInfo(response: RegistroResponse) {
        UserDefaults.standard.set(response.nombre, forKey: "nombre")
        UserDefaults.standard.set(response.contrasenia, forKey: "contrasenia")
        UserDefaults.standard.set(response.usuarioID, forKey: "usuarioID")
        UserDefaults.standard.set(response.avance, forKey: "avance")
        UserDefaults.standard.set(response.email, forKey: "email")
        UserDefaults.standard.synchronize()
    }
    
}
