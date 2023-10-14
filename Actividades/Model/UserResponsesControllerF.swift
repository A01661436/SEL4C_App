//
//  UserResponsesControllerF.swift
//  Actividades
//
//  Created by Usuario on 14/10/23.
//

import Foundation

enum UserResponsesErrorF: Error, LocalizedError{
    case itemNotFound
}
class UserResponsesControllerF{
    let baseString = "http://18.222.144.45:8000/api/respuestas_cuestionarioF"
    func insertUserResponsesF(newUserResponses:UserResponses)async throws->Void{
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(newUserResponses)
        request.httpBody = jsonData
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw UserResponsesErrorF.itemNotFound}
    }
    
}
