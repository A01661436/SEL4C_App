//
//  DiagnosticoInicialViewController.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import UIKit

class DiagnosticoInicialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*func fetchPhotoInfo() -> PhotoInfo {
        var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
        urlComponents.queryItems = [
            "api_key": "DEMO_KEY"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }

        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)

        let jsonDecoder = JSONDecoder()
        if let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200,
            let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
            print(photoInfo)
        }
    }*/

    


}
