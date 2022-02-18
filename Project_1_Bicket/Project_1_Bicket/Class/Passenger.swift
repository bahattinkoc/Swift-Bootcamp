//
//  Passenger.swift
//  Project_1_Bicket
//
//  Created by Bahattin Koç on 14.02.2022.
//

import Foundation

class Passenger{
    var name: String = ""
    var surname: String = ""
    var id: Int = 0
    
    init(name: String, surname: String, id: Int){
        self.name = name
        self.surname = surname
        self.id = id
    }
    
    func printPassenger() -> String{
        return ("\(name) \(surname) \(id)")
    }
}
