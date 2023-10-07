//
//  RecordViewController.swift
//  Actividades
//
//  Created by Usuario on 05/10/23.
//

import UIKit
import AVKit
import MobileCoreServices


class RecordViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    var imagePickerController = UIImagePickerController()
    var videoURL : URL?

    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRecordVideo(_ sender: Any){
        if
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            print("Camera Available")
            
            
            let videoPicker = UIImagePickerController()
            videoPicker.delegate =  self
            videoPicker.sourceType = .camera
            videoPicker.mediaTypes = [kUTTypeMovie as String]
            videoPicker.allowsEditing = false
            
            self.present(videoPicker,animated:true, completion: nil)
        }else{
            print("La camara no esta disponible")
        }
    }
    
    var myPicketVideo: NSURL! = NSURL()
    
    var VideoToPass:Data!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) async{
        dismiss(animated: true, completion: nil)
        
        guard
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String, mediaType ==  (kUTTypeMovie as String), let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL, UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
        else{
            return
        }
        
        if let picketVideo: NSURL = (info [UIImagePickerController.InfoKey.mediaURL] as? NSURL){
            
            
            //Aqui obtenemos la url del video en string
            self.myPicketVideo = picketVideo
            
            do {
                try? VideoToPass = Data(contentsOf: picketVideo as URL)
                let paths =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let documentsDirectory = paths[0]
                let tempPath = documentsDirectory.appendingFormat("/vid.mp4")
                let url = URL(fileURLWithPath: tempPath)
                do {
                    try? VideoToPass.write(to:url, options: []) //Aqui se escribe el video
                    try? await MultipartRequest.sendActivity(nombre: 1, estatus: 1, usuarioID: 4, entregable: VideoToPass)
                }

            }
        }
        //Soportar movie capture
        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject){
        
        let title = (error == nil) ? "Bien" : "Error"
        let message = (error == nil) ? "El video fue guardado" : "El video no fue guardado"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:nil))
        present(alert, animated:true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated:true, completion: nil)
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
