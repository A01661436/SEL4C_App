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
                let resultadosInfo = try await fetchResultadosInfo()
                updateUI(with: resultadosInfo)
            } catch {
                print(error)
            }
        }
        
    }
    
    
    
    func updateUI(with resultadosInfo: ResultadosInfo) {
        DispatchQueue.main.async {
            self.autocontrolProgressView.progress = Float(resultadosInfo.autocontrol ?? 0)/4
            self.liderazgoProgressView.progress = Float(resultadosInfo.autocontrol ?? 0)/4
            self.concienciaProgressView.progress = Float(resultadosInfo.autocontrol ?? 0)/4
            self.innovacionProgressView.progress = Float(resultadosInfo.autocontrol ?? 0)/4
        }
        
        
    }

    func displayError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func fetchResultadosInfo() async throws -> ResultadosInfo {
        var url = URL(string: "https://api.nasa.gov/planetary/apod")!


        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw ResultadosInfoError.itemNotFound
        }
        
        let jsonDecoder = JSONDecoder()
        let resultadosInfo = try jsonDecoder.decode(ResultadosInfo.self, from: data)
        return(resultadosInfo)
    }

    


}
