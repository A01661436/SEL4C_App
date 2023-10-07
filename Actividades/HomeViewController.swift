//
//  HomeViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
