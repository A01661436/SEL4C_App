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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func actualizarAction(_ sender: Any) {
        // Validar que los campos de texto no estén vacíos
        guard let nombre = nombreTextField.text, !nombre.isEmpty, let apellidos = apellidosTextField.text, !apellidos.isEmpty else {
                    // Mostrar una alerta o mensaje de error si los campos están vacíos
            mostrarError(message: "Por favor, complete todos los campos.")
            return
                }
                
                // Los campos no están vacíos, puedes realizar la acción deseada aquí.
                // Por ejemplo, actualizar la información en tu aplicación.
    }
            
            // Función para mostrar una alerta de error
        func mostrarError(message: String) {let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
}
