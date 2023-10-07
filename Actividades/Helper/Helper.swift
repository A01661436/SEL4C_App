//
//  Helper.swift
//  Actividades
//
//  Created by Usuario on 07/10/23.
//

import Foundation

func delay(durationInSeconds seconds: Double, completion: @escaping ()-> Void){
    
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}
