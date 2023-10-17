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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                let resultadosInfo = try await fetchResultadosInfo(userID: 1)
                updateUI(with: resultadosInfo)
                print(resultadosInfo)
            } catch {
                print(error)
            }
        }
        
    }
    
    
    
    func updateUI(with resultadosInfo: ResultadosInfo) {
        DispatchQueue.main.async {
            self.autocontrolProgressView.progress = Float(resultadosInfo.autocontrol_Promedio ?? 0)/4
            self.liderazgoProgressView.progress = Float(resultadosInfo.autocontrol_Promedio ?? 0)/4
            self.concienciaProgressView.progress = Float(resultadosInfo.autocontrol_Promedio ?? 0)/4
            self.innovacionProgressView.progress = Float(resultadosInfo.autocontrol_Promedio ?? 0)/4
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

    


}
