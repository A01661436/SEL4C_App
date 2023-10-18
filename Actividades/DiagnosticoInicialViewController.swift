//
//  DiagnosticoInicialViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class DiagnosticoInicialViewController: UIViewController {
    
    @IBOutlet weak var autocontrolProgressView: UIProgressView!
    @IBOutlet weak var liderazgoProgressView: UIProgressView!
    @IBOutlet weak var concienciaProgressView: UIProgressView!
    @IBOutlet weak var innovacionProgressView: UIProgressView!
    var id:Int = 0
    
    
    @IBOutlet weak var autocontrolView: UIView!
    
    @IBOutlet weak var liderazgoView: UIView!
    
    @IBOutlet weak var concienciaView: UIView!
    
    
    @IBOutlet weak var innovacionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let usuarioID = UserDefaults.standard.object(forKey: "usuarioID") as? Int {
            id = usuarioID
        }
        
        Task {
            do {
                let resultadosInfo = try await fetchResultadosInfo(userID: id)
                updateUI(with: resultadosInfo)
                print(resultadosInfo)
            } catch {
                print(error)
            }
        }
        
        applyDesign(to: autocontrolView)
        applyDesign(to: liderazgoView)
        applyDesign(to: concienciaView)
        applyDesign(to: innovacionView)
        
    }
    
    
    
    func updateUI(with resultadosInfo: ResultadosInfo) {
        DispatchQueue.main.async {
            self.autocontrolProgressView.progress = Float(resultadosInfo.Autocontrol ?? 0)/5
            self.liderazgoProgressView.progress = Float(resultadosInfo.Liderazgo ?? 0)/5
            self.concienciaProgressView.progress = Float(resultadosInfo.Conciencia ?? 0)/5
            self.innovacionProgressView.progress = Float(resultadosInfo.Innovacion ?? 0)/5
        }
        
        
    }

    func displayError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func fetchResultadosInfo(userID: Int) async throws -> ResultadosInfo {
        let url = URL(string: "http://18.222.144.45:8000/api/calculo")!
        let requestBody = ["usuarioID_id": userID]
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw ResultadosInfoError.itemNotFound
        }

        let jsonDecoder = JSONDecoder()
        let resultadosInfo = try jsonDecoder.decode(ResultadosInfo.self, from: data)
        //print(actividadesInfo)
        return resultadosInfo
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
