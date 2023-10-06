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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]){
        dismiss(animated: true, completion: nil)
        
        guard
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String, mediaType ==  (kUTTypeMovie as String), let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL, UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
        else{
            return
        }
        
        if let picketVideo: NSURL = (info [UIImagePickerController.InfoKey.mediaURL] as? NSURL){
            
            //Aqui obtenemos la url del video en string 
        }
        
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
