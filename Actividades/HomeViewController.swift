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
    
    
    @IBOutlet weak var identificaciónView: UIView!
    
    @IBOutlet weak var investigacionView: UIView!
    
    
    @IBOutlet weak var ideacionView: UIView!
    
    @IBOutlet weak var socializacionView: UIView!
    
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
        
        Task {
            do {
                let resultadosInfo = try await fetchActividadesInfo(userID:1)
                
                updateUI(with: resultadosInfo)
                print(resultadosInfo)
            } catch {
                print(error)
            }
        }
        
        

    }
    


    @IBAction func onClickDiagIncial(_ sender: UITapGestureRecognizer) {
        
        let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "diagnosticoInicial")
        vistaDestino.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vistaDestino, animated: true)
        }
        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    @IBAction func onClickAct1(_ sender: UITapGestureRecognizer) {
        
        let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act1VC")
        vistaDestino.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vistaDestino, animated: true)
        }
        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    @IBAction func onClickAct2(_ sender: UITapGestureRecognizer) {
        
        let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act2VC")
        vistaDestino.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vistaDestino, animated: true)
        }
        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    @IBAction func onClickAct3(_ sender: UITapGestureRecognizer) {
        
        let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act3VC")
        vistaDestino.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vistaDestino, animated: true)
        }
        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    @IBAction func onClickAct4(_ sender: UITapGestureRecognizer) {
        
        let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act4VC")
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
    
    func updateUI(with actividadesInfo: ActividadesInfo) {
        DispatchQueue.main.async {
            if actividadesInfo.identificacion == true {
                self.identificaciónView.backgroundColor=self.UIColorFromHex(hex: "284C81")
            }
            if actividadesInfo.investigacion == true {
                self.investigacionView.backgroundColor = self.UIColorFromHex(hex: "284C81")
            }
            if actividadesInfo.ideacion == true {
                self.ideacionView.backgroundColor = self.UIColorFromHex(hex: "284C81")
            }
            if actividadesInfo.socializacion == true {
                self.socializacionView.backgroundColor = self.UIColorFromHex(hex: "284C81")
            }
        }
    }
        
    func UIColorFromHex(hex: String) -> UIColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func fetchActividadesInfo(userID: Int) async throws -> ActividadesInfo {
        let url = URL(string: "http://18.222.144.45:8000/api/revisar_progreso")!
        let requestBody = ["id": userID]
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw ActividadesInfoError.itemNotFound
        }

        let jsonDecoder = JSONDecoder()
        let actividadesInfo = try jsonDecoder.decode(ActividadesInfo.self, from: data)
        //print(actividadesInfo)
        return actividadesInfo
    }
        

        
        
 
}
