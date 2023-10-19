//
//  LoadingViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class LoadingViewController: UIViewController{
    


    private var isUserLoggedIn = false
    var avance:Optional<Int> = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        if var avanceUsuario = UserDefaults.standard.value(forKey: "avance") as? Int {
            
            if avanceUsuario < 0 {
                avanceUsuario = 0
            }
            avance = avanceUsuario
        } else {
            avance = nil
        }
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delay(durationInSeconds: 1.30){
            self.showInitialView()
        }

    }
    

    
    private func showInitialView(){
        
        //si el usuarui está loggeado - maintabbar
        if isUserLoggedIn && avance == 0{
            let mainTabBarController = UIStoryboard(name: K.StoryBoardID.main, bundle: nil).instantiateViewController(identifier: K.StoryBoardID.mainTabBarController)
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,let window = sceneDelegate.window {
                window.rootViewController = mainTabBarController
            }
            
            
        } else if isUserLoggedIn && avance == -1{
            let diagInicialController = UIStoryboard(name: K.StoryBoardID.main, bundle: nil).instantiateViewController(identifier: "diagInicial")
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,let window = sceneDelegate.window {
                window.rootViewController = diagInicialController
            }
            
        } else{
            performSegue(withIdentifier: K.Segue.showLoginScreen, sender: nil)
        }
        
    }
    
    
}
