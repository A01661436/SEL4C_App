//
//  UserResponsesController.swift
//  Actividades
//
//  Created by Usuario on 03/10/23.
//


import Foundation


enum UserResponsesError: Error, LocalizedError{
    case itemNotFound
}
class UserResponsesController{
    let baseString = "http://18.222.144.45:8000/api/respuestas_cuestionarioI"
    func insertUserResponses(newUserResponses:UserResponses)async throws->Void{
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(newUserResponses)
        request.httpBody = jsonData
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw UserResponsesError.itemNotFound}
    }
    
}
