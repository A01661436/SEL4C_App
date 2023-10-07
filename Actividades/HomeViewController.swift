//
//  HomeViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var avanceBar: UIProgressView!
    @IBOutlet weak var progresoLabel: UILabel!
    var avance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let progreso = UserDefaults.standard.string(forKey: "avance") {
            progresoLabel.text = "Actividad \(progreso) de 4 completadas"
            avance = Int(progreso)!
        } else {
            progresoLabel.text = "Actividad 0 de 4 completadas"
        }
        
        Task {
            updateUI(avance:avance)
        }
        
        
        // Do any additional setup after loading the view.
    }
    


    @IBAction func onClickDiagIncial(_ sender: UITapGestureRecognizer) {
        
        let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "diagnosticoInicial")
        vistaDestino.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vistaDestino, animated: true)
        }
        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    func updateUI(avance: Int){
        DispatchQueue.main.async {
            self.avanceBar.progress = Float(avance)/4
        }
    }
 
}
