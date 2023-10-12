//
//  DiagCompViewController.swift
//  Actividades
//
//  Created by Usuario on 11/10/23.
//

import UIKit

class DiagCompViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func siguienteAction(_ sender: Any) {
        let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
        
        DispatchQueue.main.async {
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                let window = sceneDelegate.window
                window?.rootViewController = mainTabBarController
            }
        }
        
    }
}
