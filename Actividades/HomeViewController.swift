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
    
    
    @IBOutlet weak var progresoView: UIView!
    @IBOutlet weak var diagInicialView: UIView!
    @IBOutlet weak var identificaciónView: UIView!
    
    @IBOutlet weak var investigacionView: UIView!
    
    
    @IBOutlet weak var ideacionView: UIView!
    
    @IBOutlet weak var socializacionView: UIView!
    
    @IBOutlet weak var pitchView: UIView!
    
    @IBOutlet weak var evaluacionView: UIView!
    var avance = 0
    var id:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hola")
        if let usuarioID = UserDefaults.standard.object(forKey: "usuarioID") as? Int {
            id = usuarioID
        }
        

        
        //Diseño
        applyDesign(to: identificaciónView)
        applyDesign(to: investigacionView)
        applyDesign(to: ideacionView)
        applyDesign(to: socializacionView)
        applyDesign(to: diagInicialView)
        applyDesign(to: progresoView)
        applyDesign(to: pitchView)
        applyDesign(to: evaluacionView)
        
        if var progreso = UserDefaults.standard.string(forKey: "avance") {
            
            if Int(progreso)! < 0 {
                progreso = "1"
            }
            
            progresoLabel.text = "Actividad \(progreso) de 5 completadas"
            avance = Int(progreso)!
        } else {
            progresoLabel.text = "Actividad 0 de 5 completadas"
        }
        
        Task {
            updateUI(avance:avance)
        }
        
        Task {
            do {
                let resultadosInfo = try await fetchActividadesInfo(userID:id)
                
                
                updateUI(with: resultadosInfo)
                saveActividadesInfo(response: resultadosInfo)
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
        
        if UserDefaults.standard.bool(forKey: "identificacion") {
            mostrarError(message: "Ya completaste esta actividad")

        } else {
            let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act1VC")
            vistaDestino.hidesBottomBarWhenPushed = true
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vistaDestino, animated: true)
            }
        }
        


        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    @IBAction func onClickAct2(_ sender: UITapGestureRecognizer) {
        
        if UserDefaults.standard.bool(forKey: "investigacion") {
            mostrarError(message: "Ya completaste esta actividad")

        } else {
            let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act2VC")
            vistaDestino.hidesBottomBarWhenPushed = true
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vistaDestino, animated: true)
            }
        }
        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    @IBAction func onClickAct3(_ sender: UITapGestureRecognizer) {
        
        if UserDefaults.standard.bool(forKey: "ideacion") {
            mostrarError(message: "Ya completaste esta actividad")

        } else {
            let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act3VC")
            vistaDestino.hidesBottomBarWhenPushed = true
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vistaDestino, animated: true)
            }
        }
        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    @IBAction func onClickAct4(_ sender: UITapGestureRecognizer) {
        
        if UserDefaults.standard.bool(forKey: "socializacion") {
            mostrarError(message: "Ya completaste esta actividad")

        } else {
            let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "act4VC")
            vistaDestino.hidesBottomBarWhenPushed = true
            if let navigationController = self.navigationController {
                navigationController.pushViewController(vistaDestino, animated: true)
            }
        }
        //performSegue(withIdentifier: "showDiagInicial", sender: nil)
    }
    
    
    @IBAction func onClickPitch(_ sender: Any) {
        let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pitch")
        vistaDestino.hidesBottomBarWhenPushed = true
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vistaDestino, animated: true)
        }
    }
    
    
    @IBAction func onClickDiagFinal(_ sender: Any) {
        
        if UserDefaults.standard.bool(forKey: "identificacion"),
           UserDefaults.standard.bool(forKey: "investigacion"),
           UserDefaults.standard.bool(forKey: "ideacion"),
           UserDefaults.standard.bool(forKey: "socializacion") {
            
            let vistaDestino = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "diagFinal")
            vistaDestino.hidesBottomBarWhenPushed = true

            if let navigationController = self.navigationController {
                navigationController.pushViewController(vistaDestino, animated: true)
            }
        } else {
            mostrarError(message: "No has completado todas las actividades")
        }
 
    }
    
    func mostrarError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func updateUI(avance: Int){
        DispatchQueue.main.async {
            self.avanceBar.progress = Float(avance)/5
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
    
    func saveActividadesInfo(response: ActividadesInfo) {
        UserDefaults.standard.set(response.ideacion, forKey: "ideacion")
        UserDefaults.standard.set(response.investigacion, forKey: "investigacion")
        UserDefaults.standard.set(response.socializacion, forKey: "socializacion")
        UserDefaults.standard.set(response.identificacion, forKey: "identificacion")
        UserDefaults.standard.synchronize()
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
    
    func applyDesign(to view: UIView) {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 1
        view.layer.masksToBounds = false
    }
        

        
        
 
}
