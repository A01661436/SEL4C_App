//
//  RegistroManager.swift
//  Actividades
//
//  Created by Usuario on 30/09/23.
//

import Foundation

final class RegistroManager {
    
    static let shared = RegistroManager()
    
    private init() {}
    
    public func registraUsuario(with datosUsuario: [String: Any], completion: @escaping ((Bool)-> Void))
    {
        let urlRegistro = URL(string: "http://18.216.246.120/api/users")!
        
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
                print("SUCCESS: \(json)")
                
            } catch{
                print(error.localizedDescription)
                completion(false)
                
            }
        }
        task.resume()
    }
}
