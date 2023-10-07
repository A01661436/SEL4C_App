//
//  LoadingViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class LoadingViewController: UIViewController{
    


    private var isUserLoggedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isSignedIn = UserDefaults.standard.value(forKey: "isSignedIn") as? Bool {
            // Aquí puedes usar la variable "isSignedIn" para determinar si el usuario está autenticado o no
            if isSignedIn {
                isUserLoggedIn = true
            } else {
                isUserLoggedIn = false
            }
        }
            else {
                isUserLoggedIn = false
            }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delay(durationInSeconds: 2.0){
            self.showInitialView()
        }

    }
    

    
    private func showInitialView(){
        
        //si el usuarui está loggeado - maintabbar
        if isUserLoggedIn{
            let mainTabBarController = UIStoryboard(name: K.StoryBoardID.main, bundle: nil).instantiateViewController(identifier: K.StoryBoardID.mainTabBarController)
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,let window = sceneDelegate.window {
                window.rootViewController = mainTabBarController
            }
            
            
        } else{
            performSegue(withIdentifier: K.Segue.showLoginScreen, sender: nil)
        }
        
    }
}
