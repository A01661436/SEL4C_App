//
//  LoadingViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class LoadingViewController: UIViewController{
    
    private let isUserLoggedIn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
