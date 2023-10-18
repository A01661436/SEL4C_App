//
//  Video3ViewController.swift
//  Actividades
//
//  Created by Usuario on 17/10/23.
//

import UIKit
import AVKit
import MobileCoreServices

class Video3ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var imagePickerController = UIImagePickerController()
    var videoURL: URL?
    
    
    @IBOutlet weak var SubirVideo: UIButton!
    //Declaraciones necesarias para multiparte ------
    let url: URL = URL(string: "http://18.222.144.45:8000/api/upload")!
    
    let boundary: String = "Boundary-\(UUID().uuidString)"
    // --------------------------
    
    
    @IBAction func SubirVideo(_ sender: Any) {
        let requestBody = self.multipartFormDataBodyV(self.boundary,"Investigacion","Completado",UserDefaults.standard.integer(forKey: "usuarioID"), self.VideoToPass!)
        let request = self.generateRequest(httpBody: requestBody)
        print(requestBody)
        
        URLSession.shared.dataTask(with: request){
            data, resp, error in if let error = error{
                print(error)
                return
            }
            
            print("success")
            self.SubirVideo.isHidden = true
        }.resume()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SubirVideo.isHidden = true
    }
    
    @IBAction func playVideo(_ sender: Any) {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
        SubirVideo.isHidden = false
    }
    var myPickedVideo:NSURL! = NSURL()
    
    var VideoToPass:Data!

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        print(videoURL!)
            if let pickedVideo:NSURL = (info[UIImagePickerController.InfoKey.mediaURL] as? NSURL) {
            
            // Get Video URL
            self.myPickedVideo = pickedVideo
            
            do {
                try? VideoToPass = Data(contentsOf: pickedVideo as URL)//este es el contenido del video
                print("El video esta listo en memoria en el objeto VideoToPass")
            }
        }
        do {
            let asset = AVURLAsset(url: videoURL as! URL , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
        }
        self.dismiss(animated: true, completion: nil)
        
        let player = AVPlayer(url: videoURL!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.present(playerController, animated: true) {
            player.play()

        }
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
    
    //Multipart video
    private func multipartFormDataBodyV(_ boundary: String, _ nombre: String,_ estatus: String , _ usuarioID: Int,_ image:Data!) -> Data{
        
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
