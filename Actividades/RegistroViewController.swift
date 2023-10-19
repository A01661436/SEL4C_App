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
    @IBOutlet weak var paisTextField: UITextField!
    
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
    
    let listas = Listas()
    let instituciones = ["ITESM", "UNAM", "ITAM", "IPN", "Ibero", "UP", "LaSalle", "Otra"]
    
    
    let generos = ["Masculino", "Femenino", "Otro", "Prefiero no decirlo"]
    var disciplinas = ["disciplinas"]
    var gradosAcademicos = ["grado"]
    var paises = ["Mexico", "USA"]
    let edades = Array(15...80)
 
    
    var institucionPickerView = UIPickerView()
    var disciplinaPickerView = UIPickerView()
    var generoPickerView = UIPickerView()
    var gradoAcademicoPickerView = UIPickerView()
    var paisPickerView = UIPickerView()
    var edadPickerView = UIPickerView()
    
    var fechaNacimientoDatePicker = UIDatePicker()
    
    
    var isUsuarioValid = false
    var isContrasenaValid = false
    var isConfirmacionValid = false
    var isEmailValid = false
    
    
    
    @IBOutlet weak var registroView: UIView!
    
    
    @IBOutlet weak var tycButton: UIButton!
    
    @IBOutlet weak var tycTextView: UITextView!
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        disciplinas = listas.disciplinas
        gradosAcademicos = listas.gradosAcademico
        paises = listas.paises
        
        institucionTextField.inputView = institucionPickerView
        disciplinaTextField.inputView = disciplinaPickerView
        generoTextField.inputView = generoPickerView
        gradoAcademicoTextField.inputView = gradoAcademicoPickerView
        paisTextField.inputView = paisPickerView
        fechaNacimientoTextField.inputView = edadPickerView
        
        institucionPickerView.delegate = self
        institucionPickerView.dataSource = self
        
        disciplinaPickerView.delegate = self
        disciplinaPickerView.dataSource = self
        
        generoPickerView.delegate = self
        generoPickerView.dataSource = self
        
        gradoAcademicoPickerView.delegate = self
        gradoAcademicoPickerView.dataSource = self
        
        paisPickerView.delegate = self
        paisPickerView.dataSource = self
        
        edadPickerView.delegate = self
        edadPickerView.dataSource = self
        

        institucionPickerView.tag = 1
        disciplinaPickerView.tag = 2
        generoPickerView.tag = 3
        gradoAcademicoPickerView.tag = 4
        paisPickerView.tag = 5
        edadPickerView.tag = 6
        
        //createDatePicker()
        
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
        
        self.registroView.layer.cornerRadius = 30
        self.registroView.clipsToBounds = true
        self.registroView.layer.shadowColor = UIColor.black.cgColor
        self.registroView.layer.shadowOpacity = 0.5
        self.registroView.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.registroView.layer.shadowRadius = 1
        self.registroView.layer.masksToBounds = false
        
        updateTextView()
        
        contrasenaTextField.isSecureTextEntry = true
        confirmacionTextField.isSecureTextEntry = true
        
        
    }
    
    
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    /*func createDatePicker(){
        fechaNacimientoDatePicker.preferredDatePickerStyle = .wheels
        fechaNacimientoDatePicker.datePickerMode = .date
        fechaNacimientoTextField.inputView = fechaNacimientoDatePicker
        fechaNacimientoTextField.inputAccessoryView = createToolBar()
    }*/
    
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
        
        guard let fechaNacimiento = fechaNacimientoTextField.text, !fechaNacimiento.isEmpty, let pais = paisTextField.text, !pais.isEmpty, let genero = generoTextField.text, !genero.isEmpty, let grado = gradoAcademicoTextField.text, !grado.isEmpty, let institucion = institucionTextField.text, !institucion.isEmpty, let disciplina = disciplinaTextField.text, !disciplina.isEmpty, isEmailValid == true, isContrasenaValid == true, isConfirmacionValid == true, isEmailValid == true, flag == false else {
            
            
            mostrarError(message: "Intente de nuevo")
            return
        }
       
        //let edad = calculateAge()
        
        let datosUsuario: [String: Any] = [
            "nombre": usuarioTextField.text!,
            "contrasenia": contrasenaTextField.text!,
            "email": emailTextField.text!,
            "avance": -1,
            "genero": generoTextField.text!,
            "edad": fechaNacimientoTextField.text!,
            "pais": paisTextField.text!,
            "institucion": String(institucionTextField.text!),
            "grado": String(gradoAcademicoTextField.text!),
            "diciplina": String(disciplinaTextField.text!),
            "respuestasI":false
        ]
        
        let rm = RegistroManager()
        
        DispatchQueue.main.async {
            rm.registraUsuario(with: datosUsuario) { success in
                if success {
                    // Registro exitoso, puedes hacer algo aquí si es necesario
                    print("Registro exitoso")
                    DispatchQueue.main.async {
                        let diagInicialController = UIStoryboard(name: K.StoryBoardID.main, bundle: nil).instantiateViewController(identifier: "diagInicial")
                        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate,let window = sceneDelegate.window {
                            window.rootViewController = diagInicialController
                        }
                    }

                    
                } else {
                    // Fallo en el registro, puedes hacer algo aquí si es necesario
                    print("Fallo en el registro")
                    return
                }
            }
        }
        
        

        
        print(datosUsuario)
        
        //Realizar la solicitud de registro usando RegistroManager
        
        
        
        
        
    }
    
    
    @IBAction func iniciaSesionAction(_ sender: Any) {
        performSegue(withIdentifier: "showInicioSesion", sender: nil)
    }
    
    
    @IBAction func tycAction(_ sender: UIButton) {
        
        if(flag == false)
        {
            sender.setBackgroundImage((UIImage(named: "uncheck")), for: UIControl.State.normal)
            flag = true
        }
        else
        {
            sender.setBackgroundImage((UIImage(named: "check")), for: UIControl.State.normal)
            flag = false
        }
    }
    
    func updateTextView() {
        let path = "https://tec.mx/es/politicas-de-privacidad-del-tecnologico-de-monterrey"
        let text = tycTextView.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "términos y condiciones")
        tycTextView.attributedText = attributedString
    }
    
    func calculateAge() -> Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let birthdate = fechaNacimientoDatePicker.date
        
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: currentDate)
        
        if let age = ageComponents.year {
            return age
        }
        
        // Si no se pudo calcular la edad, puedes manejarlo de alguna otra manera, como lanzar un error o devolver un valor predeterminado.
        return 0 // Valor predeterminado en caso de error.
    }
    
    func mostrarError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
 
        case 5:
            return paises.count
            
        case 6:
            return edades.count
            
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
        
        case 5:
            return paises[row]
            
        case 6:
            return String(edades[row])
            
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
            
        case 5:
            paisTextField.text = paises[row]
            paisTextField.resignFirstResponder()
            
        case 6:
            fechaNacimientoTextField.text = String(edades[row])
            fechaNacimientoTextField.resignFirstResponder()
            
        default:
            return
        }
    }
    
    
}
