//
//  Answer.swift
//  Actividades
//
//  Created by Usuario on 03/10/23.
//

import Foundation
struct Answer:Codable{
    var question:Question
    var answer:Int
}

typealias Answers = [Answer]
