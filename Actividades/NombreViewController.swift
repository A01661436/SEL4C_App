//
//  NombreViewController.swift
//  Actividades
//
//  Created by Usuario on 06/10/23.
//

import UIKit

class NombreViewController: UIViewController {

    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var apellidosTextField: UITextField!
    @IBOutlet weak var actualizarButton: UIButton!
    var solicitudEnProceso = false
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func cambioNombre(with datosUsuario: [String: Any], completion: @escaping ((Bool)-> Void))
    {
        let url = URL(string: "")!
        
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
                print("SUCCESS: \(json)")
                
            } catch{
                print(error)
                completion(false)
                
            }
        }
        task.resume()
    }
    
    @IBAction func actualizarAction(_ sender: Any) {
        // Validar que los campos de texto no estén vacíos
        // Verificar si ya hay una solicitud en proceso
        if solicitudEnProceso {
            return // Evitar solicitudes adicionales mientras una está en curso
        }
        
        // Validar que los campos de texto no estén vacíos
        guard let nombre = nombreTextField.text, !nombre.isEmpty,
              let apellidos = apellidosTextField.text, !apellidos.isEmpty else {
            // Mostrar una alerta o mensaje de error si los campos están vacíos
            mostrarError(message: "Por favor, complete todos los campos.")
            return
        }
        

        
        // Deshabilitar temporalmente el botón para evitar múltiples solicitudes
        actualizarButton.isEnabled = false
        solicitudEnProceso = true
        
        let nombre_completo = nombre+apellidos
        
        let datosUsuario: [String: Any] = ["nombre": nombre_completo]
        
        cambioNombre(with: datosUsuario){ (success) in
            DispatchQueue.main.async {
                if success {
                    // La solicitud se realizó con éxito
                 
                    print("Solicitud POST exitosa")
                } else {
                    // Hubo un error en la solicitud
                
                    print("Error en la solicitud POST")
                }
                
                // Habilitar nuevamente el botón después de la solicitud
                self.actualizarButton.isEnabled = true
                self.solicitudEnProceso = false
            }
        }
    }
    

    
    // Función para mostrar una alerta de error
    func mostrarError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
