//
//  EcomplexityEngine.swift
//  Actividades
//
//  Created by Usuario on 03/10/23.
//

import Foundation
struct EcomplexityEngine{
    var questionIndex = 0
    var questions=Questions()
    mutating func initialize(q:Questions){
        questions = q
    }
    func getTextQuestion()->String{
        return questions[questionIndex].text
    }
    func getId()->Int{
        return questions[questionIndex].id
    }
    func getProgress()->Float{
        let progress = Float(questionIndex+1)/Float(questions.count)
        return progress
    }
    mutating func nextQuestion()->Bool{
        if questionIndex+1 < questions.count{
            questionIndex += 1
            return false
        }
        else{
            questionIndex=0
            return true
        }
    }
}
