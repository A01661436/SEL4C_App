//
//  archivosViewController.swift
//  Actividades
//
//  Created by Usuario on 14/10/23.
//

import UIKit
import AVKit
import MobileCoreServices

class archivosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //Boton para subir la imagen
    var globalImage:UIImage? = nil
    
    
    //Array de imagenes o archivos
    //let imageArray : [UIImage] = [
    //    UIImage(named: "1")!,
    //    UIImage(named: "2")!,
    //    UIImage(named: "3")!,
    //    UIImage(named: "4")!,
    //    UIImage(named: "5")!,
    //]
    //boton para subir videos
    
    @IBAction func UploadV(_ sender: UIButton) {
        let requestBody = self.multipartFormDataBodyV(self.boundary,"Investigacion","Completado","2", self.videoElegido!)
        let request = self.generateRequest(httpBody: requestBody)
        print(requestBody)
        
        URLSession.shared.dataTask(with: request){
            data, resp, error in if let error = error{
                print(error)
                return
            }
            
            print("success")
            self.Upload.isHidden = true
            self.imageView.isHidden = true
        }.resume()
    }
    
    
    //Boton para subir imagenes
    @IBAction func Upload(_ sender: UIButton)
    {
        let requestBody = self.multipartFormDataBody(self.boundary,"Investigacion","Completado","2", self.globalImage!)
        let request = self.generateRequest(httpBody: requestBody)
        print(requestBody)
        
        URLSession.shared.dataTask(with: request){
            data, resp, error in if let error = error{
                print(error)
                return
            }
            
            print("success")
            self.Upload.isHidden = true
            self.imageView.isHidden = true
        }.resume()
    }
    
    //Declaraciones necesarias para multiparte ------
    let url: URL = URL(string: "http://18.222.144.45:8000/api/upload")!
    
    let boundary: String = "Boundary-\(UUID().uuidString)"
    // --------------------------
    
    
    
    @IBOutlet weak var Upload: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    //Importante para video
    var videoPickerController = UIImagePickerController()
    var myPickedVideo:NSURL! = NSURL()
    var VideoToPass:Data!
    var videoElegido:  Data!
    var videoURL: URL?
    //Video
    
    
    //Boton de iMAGEN pata iniciar el image picker
    @IBAction func btnImagePicker(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.allowsEditing = true
        
        picker.delegate = self
        
        present(picker, animated: true)
        
    }
    
    //Boton de Video para iniciar el picker de video
        
    //Image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
        guard let image = info[.editedImage] as? UIImage else {return}
        
        //Carga imagen seleccionada en el image view
        print("---musica de atraco----")
        imageView.image = image
        globalImage = image
        //Cambia booleando para el boton Upload
        Upload.isHidden = false
        
        dismiss(animated: true)
    }
    
    //Video picker
    func videoPickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
        videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        let videoruL = videoURL!.path
        print(videoruL)
        //--------------------------------------------------
        if let pickedVideo:NSURL = (info[UIImagePickerController.InfoKey.mediaURL] as? NSURL) {
        
        // Get Video URL
        self.myPickedVideo = pickedVideo
        
        do {
            try? VideoToPass = Data(contentsOf: pickedVideo as URL)//este es el contenido del video
            print("El video esta listo en memoria en el objeto VideoToPass")
            
            let requestBody = self.multipartFormDataBodyV(self.boundary,"Investigacion","Completado","2", self.VideoToPass!)
            let request = self.generateRequest(httpBody: requestBody)
            print(requestBody)
            
            URLSession.shared.dataTask(with: request){
                data, resp, error in if let error = error{
                    print(error)
                    return
                }
                
                print("success")
                self.Upload.isHidden = true
                self.imageView.isHidden = true
            }.resume()
        }
    }
    
        
        //---------------------------------------------------
        
        //Cambia booleando para el boton Upload
        Upload.isHidden = false
        
        dismiss(animated: true)
    }
    
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
        
        let title = (error == nil) ? "Bien" : "Error"
        let message = (error == nil) ? "El video fue guardado" : "El video no se guardó"

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //------Did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Upload.isHidden = true
        

        // Do any additional setup after loading the view.
    }
    
    //----------------------multipart de envio------------------
    //URL Request
    private func generateRequest(httpBody: Data) -> URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("multipart/form-data; boundary=" + self.boundary, forHTTPHeaderField: "Content-Type")
        return request
    }
    
    
    //multipart Imagenes
    private func multipartFormDataBody(_ boundary: String, _ nombre: String,_ estatus: String , _ usuarioID: String,_ image:UIImage) -> Data{
        
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
        body.appendS("\(usuarioID + lineBreak)")
        
        
        
        if let uuid = UUID().uuidString.components(separatedBy: "-").first{
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"entregable\"; filename=\"\(uuid).jpg\"\(lineBreak) ")
            
            body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)") // image/jpeg = video.mp4/mp4
            
            body.append(image.jpegData(compressionQuality: 0.99)!)
            body.append(lineBreak)
            
        }
        
        body.append("--\(boundary)--\(lineBreak)") //End of the multipart and return
        
        
        
        return body
    }
    
    //Multipart video
    private func multipartFormDataBodyV(_ boundary: String, _ nombre: String,_ estatus: String , _ usuarioID: String,_ image:Data!) -> Data{
        
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
        body.appendS("\(usuarioID + lineBreak)")
        
        
        
        if let uuid = UUID().uuidString.components(separatedBy: "-").first{
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"entregable\"; filename=\"\(uuid).mp4\"\(lineBreak) ")
            
            body.append("Content-Type: video/mp4\(lineBreak + lineBreak)") // image/jpeg = video.mp4/mp4
            
            body.append(image)
            body.append(lineBreak)
            
        }
        
        body.append("--\(boundary)--\(lineBreak)") //End of the multipart and return
        
        
        
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
