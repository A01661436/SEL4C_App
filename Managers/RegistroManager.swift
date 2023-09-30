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
        let urlRegistro = URL(string: "")!
        
        //Completar los componentes de la URL para hacer la llamada
        var components = URLComponents()
        
        
        var request = URLRequest(url: urlRegistro)
        request.httpMethod = "POST"
        
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
