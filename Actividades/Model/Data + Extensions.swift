//
//  Data + Extensions.swift
//  Actividades
//
//  Created by Usuario on 14/10/23.
//

import Foundation

extension Data{ //Receive a string
    mutating func appendS(_ string: String){
        if let data = string.data(using: .utf8){ //Encode the string to utf8
            self.append(data)//append that data to our data
        }
    }
}
