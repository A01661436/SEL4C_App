//
//  RegistroViewController.swift
//  Actividades
//
//  Created by Usuario on 28/09/23.
//

import UIKit

class RegistroViewController: UIViewController {
    
    
    @IBOutlet weak var usuarioTextField: UITextField!
    
    @IBOutlet weak var contrasenaTextField: UITextField!
    @IBOutlet weak var confirmacionTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var institucionTextField: UITextField!
    @IBOutlet weak var disciplinaTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var gradoAcademicoTextField: UITextField!
    @IBOutlet weak var fechaNacimientoTextField: UITextField!
    
    
    @IBOutlet weak var usuarioError: UILabel!
    @IBOutlet weak var contrasenaError: UILabel!
    @IBOutlet weak var confirmacionError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var fechaNacimientoError: UILabel!
    @IBOutlet weak var generoError: UILabel!
    @IBOutlet weak var gradoAcademicoError: UILabel!
    @IBOutlet weak var institucionError: UILabel!
    @IBOutlet weak var disciplinaError: UILabel!
    
    
    @IBOutlet weak var registroButton: UIButton!
    
    
    let instituciones = ["Tec", "UNAM", "Otros"]
    let disciplinas = ["Ingeniería", "Ciencias sociales"]
    let generos = ["Hombre", "Mujer", "Otro", "Prefiero no decir"]
    let gradosAcademicos = ["Licenciatura", "Maestría", "Doctorado"]
    
    
    var institucionPickerView = UIPickerView()
    var disciplinaPickerView = UIPickerView()
    var generoPickerView = UIPickerView()
    var gradoAcademicoPickerView = UIPickerView()
    
    var fechaNacimientoDatePicker = UIDatePicker()
    
    var isUsuarioValid = false
    var isContrasenaValid = false
    var isConfirmacionValid = false
    var isEmailValid = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        institucionTextField.inputView = institucionPickerView
        disciplinaTextField.inputView = disciplinaPickerView
        generoTextField.inputView = generoPickerView
        gradoAcademicoTextField.inputView = gradoAcademicoPickerView
        
        institucionPickerView.delegate = self
        institucionPickerView.dataSource = self
        
        disciplinaPickerView.delegate = self
        disciplinaPickerView.dataSource = self
        
        generoPickerView.delegate = self
        generoPickerView.dataSource = self
        
        gradoAcademicoPickerView.delegate = self
        gradoAcademicoPickerView.dataSource = self
        
        
        institucionPickerView.tag = 1
        disciplinaPickerView.tag = 2
        generoPickerView.tag = 3
        gradoAcademicoPickerView.tag = 4
        
        createDatePicker()
        
        usuarioError.text = " "
        contrasenaError.text = " "
        confirmacionError.text = " "
        emailError.text = " "
        fechaNacimientoError.text = " "
        generoError.text = " "
        gradoAcademicoError.text = " "
        institucionError.text = " "
        disciplinaError.text = " "
        
        contrasenaTextField.addTarget(self, action: #selector(confirmacionChanged), for: .editingChanged)
        
        
    }
    
    
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    func createDatePicker(){
        fechaNacimientoDatePicker.preferredDatePickerStyle = .wheels
        fechaNacimientoDatePicker.datePickerMode = .date
        fechaNacimientoTextField.inputView = fechaNacimientoDatePicker
        fechaNacimientoTextField.inputAccessoryView = createToolBar()
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.fechaNacimientoTextField.text = dateFormatter.string(from: fechaNacimientoDatePicker.date)
        self.view.endEditing(true)
    }
    
    func resetForm(){
        registroButton.isEnabled = false
        
        usuarioError.isEnabled = false
        contrasenaError.isEnabled = false
        confirmacionError.isEnabled = false
        emailError.isEnabled = false
        
        usuarioError.text = "Obligatorio"
        contrasenaError.text = "Obligatorio"
        confirmacionError.text = "Obligatorio"
        emailError.text = "Obligatorio"
        

        
    }
    
    
    @IBAction func userChanged(_ sender: Any) {
        if let usuario = usuarioTextField.text, !usuario.isEmpty {
            usuarioError.text = " "
            isUsuarioValid = true
        } else {
            usuarioError.text = "Introduce un nombre de usuario"
            isUsuarioValid = false
        }
        
        checkForValidForm()
    }
    
    
    
    @IBAction func contrasenaChanged(_ sender: Any) {
        if let contrasena = contrasenaTextField.text
        {
            if let errorMessage = invalidContrasena(contrasena)
            {
                contrasenaError.text = errorMessage
                isContrasenaValid = false
            }
            else
            {
                isContrasenaValid = true
                contrasenaError.text = " "
            }
        }
        
        checkForValidForm()
    }
    
    func invalidContrasena(_ value: String) -> String?
    {
        if value.count < 8
        {
            return "La contrseña debe tener al menos 8 carácteres"
        }
        if containsDigit(value)
        {
            return "La contraseña debe tener al menos un número"
        }
        if containsLowerCase(value)
        {
            return "La contraseña debe tener al menos un carácter en minúsculas"
        }
        if containsUpperCase(value)
        {
            return "La contraseña debe tener al menos un carácter en mayúsculas"
        }
        return nil
    }
    
    func containsDigit(_ value: String) -> Bool
    {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsLowerCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    @IBAction func confirmacionChanged(_ sender: Any) {
        
        if let confirmacion = confirmacionTextField.text
        {
            if confirmacion != contrasenaTextField.text
            {
                confirmacionError.text = "No coinciden las contraseñas"
                isConfirmacionValid = false
            } else {
                isConfirmacionValid = true
                confirmacionError.text = " "
            }
        }
        checkForValidForm()
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        
        if let email = emailTextField.text
        {
            if let errorMessage = invalidEmail(email)
            {
                emailError.text = errorMessage
                isEmailValid = false
            } else{
                isEmailValid = true
                emailError.text = " "
            }
        }
        
        checkForValidForm()
    }
    
    func invalidEmail(_ value: String) -> String?
    {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-zA-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Correo electrónico inválido"
        }
        return nil
    }
    
    func checkForValidForm()
    {
        
        if isEmailValid == true, isUsuarioValid == true, isContrasenaValid == true, isConfirmacionValid == true {
            registroButton.isEnabled = true
            print("Jalo")
        } else{
            print("No jalo")
        }
    }
    
    @IBAction func registroAction(_ sender: Any) {
        //resetForm()
        
        let datosUsuario: [String: Any] = [
            "usuario": usuarioTextField.text!,
            "correo": emailTextField.text!,
            "contrasena": contrasenaTextField.text!
        ]
        
        DispatchQueue.main.async {
            RegistroManager.shared.registraUsuario(with: datosUsuario) { success in
                if success {
                    // Registro exitoso, puedes hacer algo aquí si es necesario
                    print("Registro exitoso")
                } else {
                    // Fallo en el registro, puedes hacer algo aquí si es necesario
                    print("Fallo en el registro")
                }
            }
        }
        
        print(datosUsuario)
        
        //Realizar la solicitud de registro usando RegistroManager
        
        
        
        
        
    }
}

extension RegistroViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return instituciones.count
            
        case 2:
            return disciplinas.count
            
        case 3:
            return generos.count
            
        case 4:
            return gradosAcademicos.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return instituciones[row]
        case 2:
            return disciplinas[row]
            
        case 3:
            return generos[row]
            
        case 4:
            return gradosAcademicos[row]
        default:
            return "Data not found"
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            institucionTextField.text = instituciones[row]
            institucionTextField.resignFirstResponder()
        case 2:
            disciplinaTextField.text = disciplinas[row]
            disciplinaTextField.resignFirstResponder()
        case 3:
            generoTextField.text = generos[row]
            generoTextField.resignFirstResponder()
            
        case 4:
            gradoAcademicoTextField.text = gradosAcademicos[row]
            gradoAcademicoTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    
}
