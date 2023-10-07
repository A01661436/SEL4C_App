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
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.showInitialView()
        }
    }
    
    private func setupViews(){
        view.backgroundColor = .black
    }
    
    private func showInitialView(){
        
        //si el usuarui está loggeado - maintabbar
        if isUserLoggedIn{
            let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabBarController")
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,let window = sceneDelegate.window {
                window.rootViewController = mainTabBarController
            }
            
            
        } else{
            performSegue(withIdentifier: "showLogin", sender: nil)
        }
        
    }
}
