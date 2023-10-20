//
//  TextoSendViewController.swift
//  Actividades
//
//  Created by Usuario on 16/10/23.
//

import UIKit

class TextoSendViewController: UIViewController {

    @IBOutlet weak var SubirT: UIButton!
    @IBOutlet weak var Rectangle3: UIView!
    @IBOutlet var textView: UITextView!
    var textSend : String = ""//Aqui tenemos para enviar el texto
    
    
    //--------------------------
    let fileName = "myFile.txt"

    
    var imagesArray = [String]()
    
    
    
    //Declaraciones necesarias para multiparte ------
    let url: URL = URL(string: "http://18.222.144.45:8000/api/upload_string")!
    
    let boundary: String = "Boundary-\(UUID().uuidString)"
    //----------------------------

        override func viewDidLoad() {
            super.viewDidLoad()
            Rectangle3.layer.cornerRadius = 10
            // Set initial text
            textView.text = ""

            // Register for text change notifications
            NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange), name: UITextView.textDidChangeNotification, object: textView)
        }
    
        
    @IBAction func SubirT(_ sender: Any) {
    
        let requestBody = self.multipartFormDataBody(self.boundary,"Ideacion","Completado",UserDefaults.standard.integer(forKey: "usuarioID"),textSend )
        print(requestBody)
        let request = self.generateRequest(httpBody: requestBody)
        print(requestBody)
        
        URLSession.shared.dataTask(with: request){
            data, resp, error in if let error = error{
                print(error)
                return
            }
            
            print("success")
            self.SubirT.isHidden = true
        }.resume()
        
        if var progreso = UserDefaults.standard.string(forKey: "avance") {
            UserDefaults.standard.set((String(Int(progreso)!+1)), forKey: "avance")
        }
        
        sleep(2)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        performSegue(withIdentifier: "video2tomain", sender: nil)
        
        
    }
    
        // Handle text changes
        @objc func textViewDidChange(_ notification: Notification) {
            if let textView = notification.object as? UITextView {
                // Access the updated text
                let newText = textView.text
                textSend = newText ?? ""
                
                print("Text changed: \(newText)")
            }
        }
    
    //URL Request
    private func generateRequest(httpBody: Data) -> URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("multipart/form-data; boundary=" + self.boundary, forHTTPHeaderField: "Content-Type")
        return request
    }
    
    //multipart  Texto.
    private func multipartFormDataBody(_ boundary: String, _ nombre: String,_ estatus: String , _ usuarioID: Int,_ image:String) -> Data{
        
        let lineBreak = "\r\n" // r =remove all spaces at the end of a string.
        var body = Data()
        
        body.appendS("--\(boundary + lineBreak)") //Adding to data body we are adding coundry and making a new line
        body.appendS("Content-Disposition: form-data; name=\"nombre\"\(lineBreak + lineBreak)") //Aqui anadimos el nombre del archivo FromName
        body.appendS("\(nombre + lineBreak)")
        //hasta aqui solo fue para el fromname
        
        body.appendS("--\(boundary + lineBreak)") //Adding to data body we are adding coundry and making a new line
        body.appendS("Content-Disposition: form-data; name=\"estatus\"\(lineBreak + lineBreak)") //Aqui anadimos el nombre del archivo FromName
        body.appendS("\(estatus + lineBreak)")
        
        
        body.appendS("--\(boundary + lineBreak)") //Adding to data body we are adding coundry and making a new line
        body.appendS("Content-Disposition: form-data; name=\"usuarioID\"\(lineBreak + lineBreak)") //Aqui anadimos el nombre del archivo FromName
        body.appendS("\(usuarioID)")
        
        
        //Adding text.
        body.appendS("--\(boundary + lineBreak)") //Adding to data body we are adding coundry and making a new line
        body.appendS("Content-Disposition: form-data; name=\"entregable\"\(lineBreak + lineBreak)") //Aqui anadimos el nombre del archivo FromName
        body.appendS("\(image + lineBreak)")
        
        body.appendS("--\(boundary)--\(lineBreak)") //End of the multipart and return
        
        
        
        return body
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
