//
//  QuestionSend.swift
//  Actividades
//
//  Created by Diego Martell on 09/10/23.
//

import Foundation

struct QuestionSend:Codable{
    let id:Int
    
}
typealias QuestionsSend = [QuestionSend]

enum QuestionErrorS: Error, LocalizedError{
    case itemNotFound
}

extension QuestionSend{
    
    static func fetchQuestions() async throws->Questions{
        let baseString = "http://18.222.144.45:8000/api/cuestionario_inicial"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let questions = try? jsonDecoder.decode(Questions.self, from: data)
        return questions!
        
    }
}
