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
            videoPicker
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
